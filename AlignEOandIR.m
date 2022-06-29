%% Find Closest timestamps with IR as basis

EO = readtable('/Volumes/Samsung_T5/SSD_Masteroppgave/EO_information.csv');
IR = readtable('/Volumes/Samsung_T5/SSD_Masteroppgave/IR_information.csv');

%% Loop through IR

header = {'IR_idx', 'IR_seq', 'IR_time', 'IR_offset_time', ...
          'EO_idx', 'EO_seq', 'EO_time', 'EO_offset_time', ...
          'error'};
aligned = array2table(zeros(0,9));
aligned.Properties.VariableNames = header;

for IR_idx=1:size(IR,1)
    
    % Get closest EO idx to current IR timestamp
    IR_timestamp = IR.offset_time(IR_idx);
    [error, EO_idx] = min(abs(IR_timestamp - EO.offset_time));

    % Collect information from IR and EO at respected indices
    new_row = array2table([table2array(IR(IR_idx, [1, 3:5])), ...
               table2array(EO(EO_idx, [1, 3:5])), ...
               error]);
    new_row.Properties.VariableNames = header;

    % Append to table
    aligned = vertcat(aligned, new_row);
    
end


% #########################################################################
% #########################################################################
%% Save aligned file to csv

writetable(aligned, '/Volumes/Samsung_T5/SSD_Masteroppgave/aligned.csv')



%%

