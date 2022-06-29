%% Fuse EO & IR

aligned = readtable('/Volumes/Samsung_T5/SSD_Masteroppgave/aligned.csv');

IR_frames_dir = '/Volumes/Samsung_T5/SSD_Masteroppgave/IR/All-Frames/';
EO_frames_dir = '/Volumes/Samsung_T5/SSD_Masteroppgave/EO/All-Frames/';

dest_dir = '/Volumes/Samsung_T5/SSD_Masteroppgave/Fused/';

% ### Optional frame combinations: ###
% EO: 131, IR: 123, Seq: 0
% EO: 133, IR: 125, Seq: 0
% EO: 144, IR: 136, Seq: 0
% EO: 174, IR: 164, Seq: 1
% EO: 265, IR: 248, Seq: 1 -- may be erronous
% EO: 665, IR: 629, Seq: 3
% EO: 690, IR: 654, Seq: 3
% EO: 705, IR: 669, Seq: 3
% EO: 733, IR: 697, Seq: 4

header = {'IR', 'EO', 'Seq'};
proposals = array2table([ 123, 131, 0; 
                          125, 133, 0; 
                          136, 144, 0; 
                          164, 174, 1; 
                          248, 265, 1; 
                          629, 665, 3; 
                          654, 690, 3;
                          669, 705, 3; 
                          697, 733, 4 ], 'VariableNames', header);


%% Match points

i = 9;

EO_i = proposals.EO(i);
IR_i = proposals.IR(i);
Seq_i = proposals.Seq(i);

IR_filename = [num2str(Seq_i) '_' num2str(IR_i, '%04.f') '.png'];
EO_filename = [num2str(Seq_i) '_' num2str(EO_i, '%04.f') '.png'];

IR_img = imread([IR_frames_dir IR_filename]);
EO_img = imread([EO_frames_dir EO_filename]);

%test = cpselect(EO_img, IR_img);
test = cpselect(EO_img, IR_img, EO_pts, IR_pts);

% montage({IR_img, EO_img})
% moving=EO=Left
% fixed=IR=Right

%% Save points

EO_path = '/Users/ola/Documents/Masteroppgave/Code/EO_fuse_pts.m';
IR_path = '/Users/ola/Documents/Masteroppgave/Code/IR_fuse_pts.m';

save(EO_path, EO_pts)
save(IR_path, IR_pts)

%% Load points

EO_path = '/Users/ola/Documents/Masteroppgave/Code/EO_pts.m';
IR_path = '/Users/ola/Documents/Masteroppgave/Code/IR_pts.m';

load(EO_path, EO_pts)
load(IR_path, IR_pts)

