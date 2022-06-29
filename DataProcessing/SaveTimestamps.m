%% ROS Toolbox function

FirstbagPath = '<bag_path>;
dirPath = '/Volumes/Samsung_T5/SSD_Masteroppgave/RosBag/split_bags/';
bag = rosbag([dirPath FirstbagPath]);

%% Load IR bag and Read Messages

bag_topic_IR = select(bag, 'Topic', '/ircam_mid'); % /ircam_mid 161 msgs  : sensor_msgs/Image
bag_topic_EO = select(bag, 'Topic', '/eocam_port'); % /ircam_mid 161 msgs  : sensor_msgs/Image

messages_IR = readMessages(bag_topic_IR, 'DataFormat', 'struct');
messages_EO = readMessages(bag_topic_EO, 'DataFormat', 'struct');

%% Offset in time
offset = 1645526389; % [s]

%% Save timestamps IR
sequence_number = 0;
modality = 'IR';

msgs = size(messages_IR, 1);
time = zeros(msgs, 1);
offset_time = zeros(msgs, 1);

for i=1:size(messages_IR,1)

    Sec = messages_IR{i}.Header.Stamp.Sec; % [s]
    NSec = messages_IR{i}.Header.Stamp.Nsec; % [10^-9 s]

    time(i) = double(Sec) + double(NSec)*10^(-9);
    offset_time(i) = time(i) - offset;

end

idx = (1:msgs)';
format = repelem(modality,msgs,1);
sequence = repelem(sequence_number,msgs,1);

info_IR = table(idx,format,sequence,time,offset_time);

%% Save timestamps EO
sequence_number = 0;
modality = 'EO';

msgs = size(messages_EO, 1);
time = zeros(msgs, 1);
offset_time = zeros(msgs, 1);

for i=1:size(messages_EO,1)

    Sec = messages_EO{i}.Header.Stamp.Sec; % [s]
    NSec = messages_EO{i}.Header.Stamp.Nsec; % [10^-9 s]

    time(i) = double(Sec) + double(NSec)*10^(-9);
    offset_time(i) = time(i) - offset;

end

idx = (1:msgs)';
format = repelem(modality,msgs,1);
sequence = repelem(sequence_number,msgs,1);

info_EO = table(idx,format,sequence,time,offset_time);





% #########################################################################
% #########################################################################
%% Use Function Instead

bagName = '212-201_2022-02-22-11-39-36_chunk_0004.bag';
sequence_number = 4;

[IR_4, EO_4] = SaveTimestampsFunc(bagName, sequence_number);


%% Concatenate Multiple

IR = vertcat(IR_0, IR_1, IR_2, IR_3, IR_4);
IR.idx = (1:size(IR,1))';

EO = vertcat(EO_0, EO_1, EO_2, EO_3, EO_4);
EO.idx = (1:size(EO,1))';

%% Save to file

writetable(IR, '/Volumes/Samsung_T5/SSD_Masteroppgave/IR_information.csv')
writetable(EO, '/Volumes/Samsung_T5/SSD_Masteroppgave/EO_information.csv')


%% ########################################################################
% #########################################################################

function [IR, EO] = SaveTimestampsFunc(bagName, sequence_number)

    % SEQUENCE 0: ROS Toolbox function
    dirPath = '/Volumes/Samsung_T5/SSD_Masteroppgave/RosBag/split_bags/';
    bag = rosbag([dirPath bagName]);

    fprintf('\nRunning timestamp funciton for seq nr: %d', sequence_number);
    fprintf('\nBag name: %s', bagName)

    % Load IR bag and Read Messages
    fprintf('\n\n%s', 'Loading messages:');
    
    bag_topic_IR = select(bag, 'Topic', '/ircam_mid'); % /ircam_mid 161 msgs  : sensor_msgs/Image
    fprintf('\n   IR load successful');
    bag_topic_EO = select(bag, 'Topic', '/eocam_port'); % /ircam_mid 161 msgs  : sensor_msgs/Image
    fprintf('\n   EO load successful');
    
    messages_IR = readMessages(bag_topic_IR, 'DataFormat', 'struct');
    fprintf('\n   IR read successful');
    messages_EO = readMessages(bag_topic_EO, 'DataFormat', 'struct');
    fprintf('\n   EO read successful');
    
    % Offset in time
    offset = 1645526389; % [s]
    
    % Save timestamps IR
    modality = 'IR';
    
    msgs = size(messages_IR, 1);
    time = zeros(msgs, 1);
    offset_time = zeros(msgs, 1);
    
    for i=1:size(messages_IR,1)
    
        Sec = messages_IR{i}.Header.Stamp.Sec; % [s]
        NSec = messages_IR{i}.Header.Stamp.Nsec; % [10^-9 s]
    
        time(i) = double(Sec) + double(NSec)*10^(-9);
        offset_time(i) = time(i) - offset;
    
    end
    
    idx = (1:msgs)';
    format = repelem(modality,msgs,1);
    sequence = repelem(sequence_number,msgs,1);
    
    IR = table(idx,format,sequence,time,offset_time);
    
    % Save timestamps EO
    modality = 'EO';
    
    msgs = size(messages_EO, 1);
    time = zeros(msgs, 1);
    offset_time = zeros(msgs, 1);
    
    for i=1:size(messages_EO,1)
    
        Sec = messages_EO{i}.Header.Stamp.Sec; % [s]
        NSec = messages_EO{i}.Header.Stamp.Nsec; % [10^-9 s]
    
        time(i) = double(Sec) + double(NSec)*10^(-9);
        offset_time(i) = time(i) - offset;
    
    end
    
    idx = (1:msgs)';
    format = repelem(modality,msgs,1);
    sequence = repelem(sequence_number,msgs,1);
    
    EO = table(idx,format,sequence,time,offset_time);

    fprintf('\n\n%s\r', 'Function complete');
end