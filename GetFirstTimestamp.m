%% ROS Toolbox function

FirstbagPath = '212-201_2022-02-22-11-39-36_chunk_0000.bag';
dirPath = '/Volumes/Samsung_T5/SSD_Masteroppgave/RosBag/split_bags/';
bag = rosbag([dirPath FirstbagPath]);

%% Load IR bag and Read Messages

bag_topic_IR = select(bag, 'Topic', '/ircam_mid'); % /ircam_mid 161 msgs  : sensor_msgs/Image
bag_topic_EO = select(bag, 'Topic', '/eocam_port'); % /ircam_mid 161 msgs  : sensor_msgs/Image

messages_IR = readMessages(bag_topic_IR, 1:1, 'DataFormat', 'struct');
messages_EO = readMessages(bag_topic_EO, 1:1, 'DataFormat', 'struct');

%% Display Stamps

First_IR = messages_IR{1}.Header.Stamp;
First_EO = messages_EO{1}.Header.Stamp;
