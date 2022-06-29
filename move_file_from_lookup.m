%% TEST - OBJECT and LAND %%%%% 14 BIT %%%%%

results = '';

base_path = '/Volumes/Samsung_T5/Haak_data/Flight3/';
path = '/Volumes/Samsung_T5/Haak_data/Flight3/20170926_full-norm/';
files = dir(fullfile('/Volumes/Samsung_T5/Haak_data/Flight3/20170926_full-norm/*.png'));

Anomalies_object = readtable('/Volumes/Samsung_T5/Haak_data/Flight3/Anomalies_object.csv', 'VariableNamingRule', 'preserve').Anomalies_object;
Anomalies_land   = readtable('/Volumes/Samsung_T5/Haak_data/Flight3/Anomalies_land.csv', 'VariableNamingRule', 'preserve').Anomalies_land;
Anomalies_all    = readtable('/Volumes/Samsung_T5/Haak_data/Flight3/Anomalies_all.csv', 'VariableNamingRule', 'preserve').Anomalies_all;
True             = readtable('/Volumes/Samsung_T5/Haak_data/Flight3/True.csv', 'VariableNamingRule', 'preserve').True;

frames = size(files, 1);
%frames = 5;

write = true;
show  = false;
doMontage = false;

for i=1:frames
    disp([num2str(i) '/' num2str(frames)])

    
    check_str = [num2str(i, '%04.f') '.png'];
    
    isTrue = any(strcmp(check_str, True));
    isObject = any(strcmp(check_str, Anomalies_object));
    isLand = any(strcmp(check_str, Anomalies_land));
    
    path_14bit = [path files(i).name];
    img_14bit = double(imread(path_14bit));
    
    source_path = [path num2str(i, '%05.f') '.png'];
    
    if isTrue
        copy_dir   = [base_path '_True_Fullnorm/'];
        copyfile(source_path, copy_dir)

        disp(copy_dir)
    end
    
    if isObject
        copy_dir   = [base_path '_Anomalies_object_Fullnorm/'];
        copyfile(source_path, copy_dir)

        disp(copy_dir)
    end
    
    if isLand
        copy_dir   = [base_path '_Anomalies_land_Fullnorm/'];
        copyfile(source_path, copy_dir)

        disp(copy_dir)
    end
     
end
