%% ROS Toolbox function
bagPath = '212-201_2022-02-22-11-39-36_chunk_0000.bag';
sequence = 0;
idx_offset = 0; % which idx to start from [first frame will be offset + 1]

dirPath = '/Volumes/Samsung_T5/SSD_Masteroppgave/RosBag/split_bags/';
save_folder = '/Volumes/Samsung_T5/SSD_Masteroppgave/EO/All-Frames/';

EO_bag = rosbag([dirPath bagPath]);
% rosbag info [dirPath bagPath]

% #############################
% Load EO bag and read message
bag_topic_EO = select(EO_bag, 'Topic', '/eocam_port'); % /eocam_port 172 msgs  : sensor_msgs/Image
messages_EO = readMessages(bag_topic_EO, 'DataFormat', 'struct');

% messages_EO = readMessages(bag_topic_EO, 1:10, 'DataFormat', 'struct');

%% Read and Save EO imgs

for i=1:size(messages_EO,1)
    display([num2str(i) ' of ' num2str(size(messages_EO,1))])
    [img, alpha] = rosReadImage(messages_EO{i});
    
    time = bag_topic_EO.MessageList.Time(i);
    filename = [num2str(sequence) '_' num2str(idx, '%04.f') '.png'];
    imwrite(img, [save_folder filename]);
end






% #########################################################################
% #########################################################################
%% Show image
for i=1:size(messages_EO,1)
    [img, alpha] = rosReadImage(messages_EO{i});
    time = bag_topic_EO.MessageList.Time(i);
    if i > 1
        delta_t = bag_topic_EO.MessageList.Time(i) - bag_topic_EO.MessageList.Time(i-1);
    else
        delta_t = 0;
    end
    info = ['i: ' num2str(i) '/' num2str(size(messages_EO,1)) ', time: ' num2str(time) ' [s]' ', \Deltat: ' num2str(delta_t) ' [s]'];

    imshow(img)
    text(100, 100, info, 'FontSize', 25)
    pause(0.1)
end
