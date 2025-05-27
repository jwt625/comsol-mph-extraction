function convert_mph_to_m(file_list_path, output_base_dir, test_mode)
% CONVERT_MPH_TO_M - Convert COMSOL .mph files to MATLAB .m files
%
% Usage:
%   convert_mph_to_m('file_list.txt', 'mphs', false)  % Full conversion
%   convert_mph_to_m('test_file_list.txt', 'mphs', true)  % Test mode
%
% Inputs:
%   file_list_path - Path to text file containing list of .mph files
%   output_base_dir - Base directory for output (should match Python extraction)
%   test_mode - Boolean, if true runs on limited files for testing

if nargin < 3
    test_mode = false;
end

if nargin < 2
    output_base_dir = 'mphs';
end

if nargin < 1
    file_list_path = 'file_list.txt';
end

% Get current directory (base path for .mph files)
base_path = pwd;

fprintf('=== COMSOL .mph to .m Converter ===\n');
fprintf('Base directory: %s\n', base_path);
fprintf('File list: %s\n', file_list_path);
fprintf('Output directory: %s\n', output_base_dir);
fprintf('Test mode: %s\n', string(test_mode));
fprintf('\n');

% Check if file list exists
if ~exist(file_list_path, 'file')
    error('File list not found: %s', file_list_path);
end

% Read the file list
fid = fopen(file_list_path, 'r');
if fid == -1
    error('Cannot open file list: %s', file_list_path);
end

mph_files = {};
original_relative_paths = {};  % Store original relative paths for directory naming
while ~feof(fid)
    line = fgetl(fid);
    if ischar(line) && ~isempty(strtrim(line))
        % Store original relative path
        relative_path = strtrim(line);
        original_relative_paths{end+1} = relative_path;
        
        % Convert relative path to absolute path
        absolute_path = fullfile(base_path, relative_path);
        mph_files{end+1} = absolute_path;
    end
end
fclose(fid);

total_files = length(mph_files);
fprintf('Found %d .mph files to process\n', total_files);

% Limit files for test mode
if test_mode && total_files > 5
    mph_files = mph_files(1:5);
    original_relative_paths = original_relative_paths(1:5);
    total_files = 5;
    fprintf('Test mode: Processing only first %d files\n', total_files);
end

% Initialize statistics
stats = struct();
stats.total_files = total_files;
stats.processed_files = 0;
stats.failed_files = 0;
stats.total_size = 0;

% Create log arrays
conversion_log = cell(total_files, 1);

% Create output directory if it doesn't exist
if ~exist(output_base_dir, 'dir')
    mkdir(output_base_dir);
end

% Initialize progress tracking
fprintf('\nStarting conversion process...\n');
start_time = tic;

% Process each file with progress bar
for i = 1:total_files
    mph_file = mph_files{i};
    original_path = original_relative_paths{i};
    
    % Update progress
    progress_percent = (i-1) / total_files * 100;
    elapsed_time = toc(start_time);
    if i > 1
        avg_time_per_file = elapsed_time / (i-1);
        remaining_files = total_files - (i-1);
        eta = avg_time_per_file * remaining_files;
        eta_str = format_time(eta);
    else
        eta_str = 'calculating...';
    end
    
    % Display progress bar
    bar_length = 50;
    filled_length = round(bar_length * (i-1) / total_files);
    bar = [repmat('█', 1, filled_length), repmat('░', 1, bar_length - filled_length)];
    
    fprintf('\r[%s] %3.1f%% (%d/%d) ETA: %s | Processing: %s', ...
        bar, progress_percent, i-1, total_files, eta_str, get_filename(mph_file));
    
    % Process current file using original relative path for directory naming
    result = process_single_mph_file(mph_file, output_base_dir, original_path);
    
    % Update statistics
    if strcmp(result.status, 'success')
        stats.processed_files = stats.processed_files + 1;
        if isfield(result, 'file_size')
            stats.total_size = stats.total_size + result.file_size;
        end
    else
        stats.failed_files = stats.failed_files + 1;
    end
    
    % Store result
    conversion_log{i} = struct('file', mph_file, 'result', result);
end

% Final progress update
fprintf('\r[%s] 100.0%% (%d/%d) Complete!%s\n', ...
    repmat('█', 1, bar_length), total_files, total_files, repmat(' ', 1, 50));

% Generate summary
total_time = toc(start_time);
fprintf('\n=== Conversion Complete ===\n');
fprintf('Total time: %s\n', format_time(total_time));
fprintf('Processed: %d/%d files\n', stats.processed_files, stats.total_files);
fprintf('Failed: %d files\n', stats.failed_files);
fprintf('Total size processed: %.2f MB\n', stats.total_size / (1024*1024));
fprintf('Average time per file: %.2f seconds\n', total_time / total_files);

% Save detailed log
log_file = fullfile(output_base_dir, 'matlab_conversion_log.mat');
save(log_file, 'conversion_log', 'stats', 'mph_files');
fprintf('Detailed log saved to: %s\n', log_file);

% Save human-readable summary
summary_file = fullfile(output_base_dir, 'matlab_conversion_summary.txt');
write_summary_file(summary_file, stats, conversion_log, total_time);
fprintf('Summary saved to: %s\n', summary_file);

% Display failed files if any
failed_files = {};
for i = 1:length(conversion_log)
    if ~strcmp(conversion_log{i}.result.status, 'success')
        failed_files{end+1} = conversion_log{i}.file;
    end
end

if ~isempty(failed_files)
    fprintf('\nFailed files:\n');
    for i = 1:min(10, length(failed_files))
        fprintf('  - %s: %s\n', failed_files{i}, conversion_log{i}.result.status);
    end
    if length(failed_files) > 10
        fprintf('  ... and %d more (see log file for details)\n', length(failed_files) - 10);
    end
end

end

function result = process_single_mph_file(mph_file_path, output_base_dir, original_relative_path)
% Process a single .mph file and convert to .m file

result = struct();
result.status = 'unknown';
result.error_message = '';
result.output_file = '';
result.file_size = 0;

try
    % Check if source file exists
    if ~exist(mph_file_path, 'file')
        result.status = 'file_not_found';
        result.error_message = sprintf('Source .mph file not found: %s', mph_file_path);
        return;
    end
    
    % Get file size
    file_info = dir(mph_file_path);
    result.file_size = file_info.bytes;
    
    % Create sanitized path for output using original relative path
    sanitized_path = strrep(original_relative_path, '/', '_');
    sanitized_path = strrep(sanitized_path, '\', '_');
    sanitized_path = strrep(sanitized_path, '.mph', '');
    
    % Create output directory structure
    output_dir = fullfile(output_base_dir, sanitized_path);
    if ~exist(output_dir, 'dir')
        mkdir(output_dir);
    end
    
    % Define output .m file path
    [~, filename, ~] = fileparts(mph_file_path);
    output_m_file = fullfile(output_dir, [filename, '.m']);
    
    % Load the COMSOL model
    model = mphload(mph_file_path);
    
    % Save as .m file
    mphsave(model, output_m_file);
    
    % Verify the output file was created
    if exist(output_m_file, 'file')
        result.status = 'success';
        result.output_file = output_m_file;
    else
        result.status = 'save_failed';
        result.error_message = 'Output .m file was not created';
    end
    
catch ME
    result.status = 'error';
    result.error_message = ME.message;
end

end

function filename = get_filename(filepath)
% Extract filename from full path
[~, name, ext] = fileparts(filepath);
filename = [name, ext];
if length(filename) > 30
    filename = [filename(1:27), '...'];
end
end

function time_str = format_time(seconds)
% Format time in human readable format
if seconds < 60
    time_str = sprintf('%.1fs', seconds);
elseif seconds < 3600
    minutes = floor(seconds / 60);
    secs = mod(seconds, 60);
    time_str = sprintf('%dm %.1fs', minutes, secs);
else
    hours = floor(seconds / 3600);
    minutes = floor(mod(seconds, 3600) / 60);
    time_str = sprintf('%dh %dm', hours, minutes);
end
end

function write_summary_file(filename, stats, conversion_log, total_time)
% Write human-readable summary file

fid = fopen(filename, 'w');
if fid == -1
    warning('Could not create summary file: %s', filename);
    return;
end

fprintf(fid, '=== COMSOL .mph to .m Conversion Summary ===\n\n');
fprintf(fid, 'Total files in list: %d\n', stats.total_files);
fprintf(fid, 'Successfully processed: %d\n', stats.processed_files);
fprintf(fid, 'Failed to process: %d\n', stats.failed_files);
fprintf(fid, 'Total size processed: %.2f MB\n', stats.total_size / (1024*1024));
fprintf(fid, 'Total conversion time: %s\n', format_time(total_time));
fprintf(fid, 'Average time per file: %.2f seconds\n\n', total_time / stats.total_files);

% List failed files if any
failed_count = 0;
for i = 1:length(conversion_log)
    if ~strcmp(conversion_log{i}.result.status, 'success')
        failed_count = failed_count + 1;
    end
end

if failed_count > 0
    fprintf(fid, 'Failed files (%d):\n', failed_count);
    count = 0;
    for i = 1:length(conversion_log)
        if ~strcmp(conversion_log{i}.result.status, 'success')
            count = count + 1;
            if count <= 20  % Show first 20 failed files
                fprintf(fid, '  - %s: %s\n', conversion_log{i}.file, conversion_log{i}.result.status);
            end
        end
    end
    if failed_count > 20
        fprintf(fid, '  ... and %d more (see .mat log file for complete list)\n', failed_count - 20);
    end
end

fclose(fid);
end 