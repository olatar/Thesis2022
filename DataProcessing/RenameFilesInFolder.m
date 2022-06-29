%% Rename files in folder

sequence = 4;
idx_offset = 707; % which idx to start from [first frame will be offset + 1]
source_dir = '/Volumes/Samsung_T5/SSD_Masteroppgave/EO/04_22Feb/';

dest_dir = '/Volumes/Samsung_T5/SSD_Masteroppgave/EO/All-Frames/';

% Get all PDF files in the current folder
files = dir([source_dir '*.png']);

% Loop through each
for i = 1:length(files)

    if files(i).name(1) ~= '.'
        prev_idx = split(files(i).name, '_');
        
        idx = str2double(prev_idx{1}) + idx_offset;
        filename = [num2str(sequence) '_' num2str(idx, '%04.f') '.png'];
        source = [source_dir files(i).name];
        dest = [dest_dir filename];

        copyfile(source, dest);

        fprintf('\n%s --> %s', files(i).name, filename);
    end
end