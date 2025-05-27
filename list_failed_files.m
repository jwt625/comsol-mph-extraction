

%%

clc;

failed_count = 0;
for i = 1:length(conversion_log)
    if ~strcmp(conversion_log{i}.result.status, 'success')
        failed_count = failed_count + 1;
    end
end


    % fprintf(fid, 'Failed files (%d):\n', failed_count);
    count = 0;
    for i = 1:length(conversion_log)
        if ~strcmp(conversion_log{i}.result.status, 'success')
            count = count + 1;
            if count <= 2000  % Show first 20 failed files
                fprintf('  - %s: %s\n\terr msg: %s\n', conversion_log{i}.file, ...
                    conversion_log{i}.result.status, ...
                    conversion_log{i}.result.error_message);
            end
        end
    end
