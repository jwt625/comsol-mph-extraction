function analyze_failed_conversions(log_file_path, output_dir)
% ANALYZE_FAILED_CONVERSIONS - Extract and analyze failed .mph to .m conversions
%
% Usage:
%   analyze_failed_conversions()  % Uses default paths
%   analyze_failed_conversions('mphs/matlab_conversion_log.mat')
%   analyze_failed_conversions('mphs/matlab_conversion_log.mat', 'mphs')
%
% Inputs:
%   log_file_path - Path to the matlab_conversion_log.mat file
%   output_dir - Directory to save the failed files analysis

if nargin < 1
    log_file_path = 'mphs/matlab_conversion_log.mat';
end

if nargin < 2
    output_dir = fileparts(log_file_path);
    if isempty(output_dir)
        output_dir = '.';
    end
end

fprintf('=== Failed Conversion Analysis ===\n');
fprintf('Log file: %s\n', log_file_path);
fprintf('Output directory: %s\n', output_dir);
fprintf('\n');

% Check if log file exists
if ~exist(log_file_path, 'file')
    error('Log file not found: %s', log_file_path);
end

% Load the conversion log
fprintf('Loading conversion log...\n');
try
    log_data = load(log_file_path);
    conversion_log = log_data.conversion_log;
    stats = log_data.stats;
    if isfield(log_data, 'mph_files')
        mph_files = log_data.mph_files;
    else
        mph_files = {};
    end
catch ME
    error('Failed to load log file: %s', ME.message);
end

fprintf('Total files in log: %d\n', length(conversion_log));

% Extract failed files information
failed_files = {};
failed_info = struct();
failure_types = {};

for i = 1:length(conversion_log)
    entry = conversion_log{i};
    if ~strcmp(entry.result.status, 'success')
        failed_files{end+1} = entry.file;
        
        % Store detailed failure information
        failed_info(end+1).file_path = entry.file;
        failed_info(end).status = entry.result.status;
        failed_info(end).error_message = entry.result.error_message;
        failed_info(end).file_size = entry.result.file_size;
        failed_info(end).output_file = entry.result.output_file;
        
        % Track failure types
        failure_types{end+1} = entry.result.status;
    end
end

num_failed = length(failed_files);
fprintf('Failed files found: %d\n', num_failed);

if num_failed == 0
    fprintf('No failed conversions found!\n');
    return;
end

% Analyze failure types
unique_failure_types = unique(failure_types);
fprintf('\nFailure type breakdown:\n');
for i = 1:length(unique_failure_types)
    failure_type = unique_failure_types{i};
    count = sum(strcmp(failure_types, failure_type));
    percentage = count / num_failed * 100;
    fprintf('  %-20s: %3d files (%.1f%%)\n', failure_type, count, percentage);
end

% Analyze file sizes of failed files
failed_sizes = [failed_info.file_size];
failed_sizes = failed_sizes(failed_sizes > 0);  % Remove zero sizes

if ~isempty(failed_sizes)
    fprintf('\nFailed file size statistics:\n');
    fprintf('  Average size: %.2f MB\n', mean(failed_sizes) / (1024*1024));
    fprintf('  Median size:  %.2f MB\n', median(failed_sizes) / (1024*1024));
    fprintf('  Min size:     %.2f MB\n', min(failed_sizes) / (1024*1024));
    fprintf('  Max size:     %.2f MB\n', max(failed_sizes) / (1024*1024));
end

% Save detailed failed files report
failed_report_file = fullfile(output_dir, 'failed_conversions_detailed.txt');
fprintf('\nSaving detailed report to: %s\n', failed_report_file);

fid = fopen(failed_report_file, 'w');
if fid == -1
    warning('Could not create detailed report file: %s', failed_report_file);
else
    fprintf(fid, '=== Failed COMSOL .mph to .m Conversions - Detailed Report ===\n\n');
    fprintf(fid, 'Generated: %s\n', datestr(now));
    fprintf(fid, 'Total failed files: %d\n\n', num_failed);
    
    % Failure type summary
    fprintf(fid, 'Failure Type Summary:\n');
    for i = 1:length(unique_failure_types)
        failure_type = unique_failure_types{i};
        count = sum(strcmp(failure_types, failure_type));
        percentage = count / num_failed * 100;
        fprintf(fid, '  %-20s: %3d files (%.1f%%)\n', failure_type, count, percentage);
    end
    fprintf(fid, '\n');
    
    % Detailed file list
    fprintf(fid, 'Detailed Failed Files List:\n');
    fprintf(fid, '%-60s %-15s %-10s %s\n', 'File Path', 'Status', 'Size (MB)', 'Error Message');
    fprintf(fid, '%s\n', repmat('-', 1, 120));
    
    for i = 1:length(failed_info)
        file_size_mb = failed_info(i).file_size / (1024*1024);
        if failed_info(i).file_size > 0
            size_str = sprintf('%.2f', file_size_mb);
        else
            size_str = 'N/A';
        end
        
        % Truncate long paths and error messages for readability
        file_path = failed_info(i).file_path;
        if length(file_path) > 58
            file_path = ['...' file_path(end-54:end)];
        end
        
        error_msg = failed_info(i).error_message;
        if length(error_msg) > 50
            error_msg = [error_msg(1:47) '...'];
        end
        
        fprintf(fid, '%-60s %-15s %-10s %s\n', ...
            file_path, failed_info(i).status, size_str, error_msg);
    end
    
    fclose(fid);
end

% Save failed files list for easy reprocessing
failed_list_file = fullfile(output_dir, 'failed_files_list.txt');
fprintf('Saving failed files list to: %s\n', failed_list_file);

fid = fopen(failed_list_file, 'w');
if fid == -1
    warning('Could not create failed files list: %s', failed_list_file);
else
    for i = 1:length(failed_files)
        fprintf(fid, '%s\n', failed_files{i});
    end
    fclose(fid);
end

% Save MATLAB data for further analysis
failed_data_file = fullfile(output_dir, 'failed_conversions_data.mat');
fprintf('Saving MATLAB data to: %s\n', failed_data_file);
save(failed_data_file, 'failed_info', 'failed_files', 'failure_types', 'unique_failure_types');

% Display sample of failed files
fprintf('\nSample of failed files (first 10):\n');
for i = 1:min(10, length(failed_info))
    fprintf('  %d. %s\n', i, get_filename(failed_info(i).file_path));
    fprintf('     Status: %s\n', failed_info(i).status);
    if ~isempty(failed_info(i).error_message)
        error_msg = failed_info(i).error_message;
        if length(error_msg) > 80
            error_msg = [error_msg(1:77) '...'];
        end
        fprintf('     Error: %s\n', error_msg);
    end
    fprintf('\n');
end

if length(failed_info) > 10
    fprintf('  ... and %d more (see detailed report for complete list)\n', length(failed_info) - 10);
end

fprintf('\n=== Analysis Complete ===\n');

end

function filename = get_filename(filepath)
% Extract filename from full path
[~, name, ext] = fileparts(filepath);
filename = [name, ext];
end 