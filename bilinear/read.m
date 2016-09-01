fid     = sprintf('video455.mat');
blue    = importdata(fid);

fid     = sprintf('video456.mat');
green   = importdata(fid);

fid=sprintf('video457.mat');
red    = importdata(fid);


fid=sprintf('video458.mat');
NIR    = importdata(fid);

implay(red*20);
implay(blue*20);
implay(green*20);
implay(NIR*20);