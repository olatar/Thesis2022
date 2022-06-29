%% Synthesize EO and IR and save to folder - with meta info

aligned = readtable('/Volumes/Samsung_T5/SSD_Masteroppgave/aligned.csv');

IR_frames_dir = '/Volumes/Samsung_T5/SSD_Masteroppgave/IR/All-Frames/';
EO_frames_dir = '/Volumes/Samsung_T5/SSD_Masteroppgave/EO/All-Frames/';

dest_dir = '/Volumes/Samsung_T5/SSD_Masteroppgave/Aligned/';

for i=1:size(aligned,1)

    IR_filename = [num2str(aligned.IR_seq(i)) '_' num2str(aligned.IR_idx(i), '%04.f') '.png'];
    EO_filename = [num2str(aligned.EO_seq(i)) '_' num2str(aligned.EO_idx(i), '%04.f') '.png'];

    IR_path = [IR_frames_dir IR_filename];
    EO_path = [EO_frames_dir EO_filename];

    EO_img = imread(EO_path);
    IR_img = imread(IR_path);

    info_IR = ['IR idx: ' num2str(aligned.IR_idx(i)) ', time: ' num2str(aligned.IR_offset_time(i), '%.5f') ' [s]'];
    info_EO = ['EO idx: ' num2str(aligned.EO_idx(i)) ', time: ' num2str(aligned.EO_offset_time(i), '%.5f') ' [s]'];
    info_error = ['Error: ' num2str(aligned.error(i), '%.4f'), ' [s] (IR-EO)'];

    % Error text
    box_color = {'blue'};
    position = [2450 2450];

    EO_img_error = insertText(EO_img, position, info_error,'FontSize',100, ...
        'BoxColor',box_color,'BoxOpacity',0.35,'TextColor','white');


    % EO text
    box_color = {'red'};
    position = [400 2450];

    EO_img_text = insertText(EO_img_error, position, info_EO,'FontSize',100, ...
        'BoxColor',box_color,'BoxOpacity',0.25,'TextColor','white');

    % IR text
    box_color = {'red'};
    position = [50 390];

    IR_img_text = insertText(IR_img, position, info_IR,'FontSize',16, ...
        'BoxColor',box_color,'BoxOpacity',0.25,'TextColor','white');

    % Save synthesized image
    m = montage({EO_img_text, IR_img_text});
    imwrite(m.CData,[dest_dir num2str(i, '%04.f') '.png']);
end