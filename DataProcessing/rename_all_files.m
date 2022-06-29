%% RENAME ALL FILES
ppm_files = dir(fullfile('/Volumes/Samsung_T5/Haak_data/Flight3/20170926_simple-naming/*.ppm'));
ppm_dir = '/Volumes/Samsung_T5/Haak_data/Flight3/20170926_simple-naming/';

frames = size(IR_frames_dir,1);

for i=1:frames

    if i <= 2
        disp('Nope')
    else
        disp('Go')
        ppm_path = [ppm_dir ppm_files(i).name];
        ppm_path_clean = [ppm_dir num2str(i, '%05.f') '.ppm'];
    
        disp(ppm_path)
        disp(ppm_path_clean)
    
        movefile(ppm_path, ppm_path_clean)
    end
end