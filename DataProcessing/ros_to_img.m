%% ROS Toolbox function
path_bag = '<bag_path>';
bag = rosbag(path_bag);

% bag.StartTime 'double'
% bag.EndTime 'double'
% bag.AvailableTopics 'table'
% bag.AvailableFrames 'cell (with strings)'

rosbag info ''





% ------------------------------------------------------------------------
%% Load EO bag and Read Message
bag_topic_EO = select(bag, 'Topic', '/eocam_port'); % /eocam_port 172 msgs  : sensor_msgs/Image

%messages_EO = readMessages(bag_topic_EO, 1:10, 'DataFormat', 'struct');
messages_EO = readMessages(bag_topic_EO, 'DataFormat', 'struct');

%% Read and Save EO Img
save_folder = '/Volumes/Samsung_T5/SSD_Masteroppgave/EO/04_22Feb/';

for i=1:size(messages_EO,1)
    display([num2str(i) ' of ' num2str(size(messages_EO,1))])
    [img, alpha] = rosReadImage(messages_EO{i});
    
    time = bag_topic_EO.MessageList.Time(i);
    filename = [num2str(i) '_' num2str(time) '.png'];
    imwrite(img, [save_folder filename]);
end

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







% ------------------------------------------------------------------------
%% Load IR bag and Read Message
bag_topic_IR = select(bag, 'Topic', '/ircam_mid'); % /ircam_mid 161 msgs  : sensor_msgs/Image

%messages_IR = readMessages(bag_topic_IR, 1:10, 'DataFormat', 'struct');
messages_IR = readMessages(bag_topic_IR, 'DataFormat', 'struct');

%% Read IR Img

imgs = zeros(messages_IR{1}.Height, messages_IR{1}.Width, size(messages_IR,1));

for i=1:size(messages_IR,1)
    [img, alpha] = rosReadImage(messages_IR{i});
    imgs(:, :, i) = img;
end

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

%% Save to folder
save_folder = '/Volumes/Samsung_T5/SSD_Masteroppgave/IR/00_22Feb/';


for i=1:size(messages_IR,1)
    time = bag_topic_IR.MessageList.Time(i);
    filename = ['00_frame_' num2str(i,'%03.f') '.png'];
    imwrite(uint8(imgs(:,:,i)), [save_folder filename]);
end
