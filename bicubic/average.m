function [video_avg] = average(video)

%video = load('video.mat');

%%show the video
%implay(video.Data_Crop./4097);

%% initialization
[m,n,k]=size(video);
video_2 = im2double(video);
video_all = zeros(m,n);
x=1;
y=1;
z=1;

% k =2;

%% add all values and get average value
for i = 1:k
    video_all = video_all + (video_2(:,:,i));
end

video_avg = video_all./k;