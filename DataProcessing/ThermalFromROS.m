%% ROS Toolbox function
bagPath = '<>';
sequence = 4;
idx_offset = 670; % which idx to start from [first frame will be offset + 1]

dirPath = '/Volumes/Samsung_T5/SSD_Masteroppgave/RosBag/split_bags/';
save_folder = '/Volumes/Samsung_T5/SSD_Masteroppgave/IR/All-Frames/';

IR_bag = rosbag([dirPath bagPath]);
% rosbag info [dirPath bagPath]

% #############################
% Load IR bag and read messages
bag_topic_IR = select(IR_bag, 'Topic', '/ircam_mid'); % /ircam_mid 161 msgs  : sensor_msgs/Image
messages_IR = readMessages(bag_topic_IR, 'DataFormat', 'struct');

% messages_IR = readMessages(bag_topic_IR, 1:10, 'DataFormat', 'struct');

% ############
% Read IR imgs
imgs = zeros(messages_IR{1}.Height, messages_IR{1}.Width, size(messages_IR,1));

for i=1:size(messages_IR,1)
    [img, alpha] = rosReadImage(messages_IR{i});
    imgs(:, :, i) = img;
end

% ##############
% Save to folder

for i=1:size(messages_IR,1)
    time = bag_topic_IR.MessageList.Time(i);
    idx = idx_offset + i;
    filename = [num2str(sequence) '_' num2str(idx, '%04.f') '.png'];
    imwrite(uint8(imgs(:,:,i)), [save_folder filename]);
end




% #########################################################################
% #########################################################################
%% Show image
for i=1:size(imgs,3)
    time = bag_topic_IR.MessageList.Time(i);
    if i > 1
        delta_t = bag_topic_IR.MessageList.Time(i) - bag_topic_IR.MessageList.Time(i-1);
    else
        delta_t = 0;
    end
    info = ['i: ' num2str(i) '/' num2str(size(messages_IR,1)) ', time: ' num2str(time) ' [s]' ', \Deltat: ' num2str(delta_t) ' [s]'];
    
    text(25, 25, info, 'FontSize', 25)
    imshow(imgs(:,:,i),[])
    pause(0.1)
end