clc;
clear;
close all;
imtool close all;

fid     = sprintf('video455.mat');
blue    = importdata(fid);

%
fid     = sprintf('video456.mat');
green   = importdata(fid);

%
fid=sprintf('video457.mat');
red    = importdata(fid);

%
fid=sprintf('video458.mat');
NIR    = importdata(fid);

%% average the vedio

red_O   = average(red);
green_O = average(green);
blue_O  = average(blue);
NIR_O   = average(NIR);

RGB_I(1:1024,1:1024,1)=red_O(100:1123, 300:1323); %R
RGB_I(1:1024,1:1024,2)=green_O(100:1123, 300:1323); %G
RGB_I(1:1024,1:1024,3)=blue_O(100:1123, 300:1323); %B
imtool(RGB_I*20,'DisplayRange', [0 255]);

NIR_avg(1:1024,1:1024)=NIR_O(100:1123, 300:1323); %NIR
imtool(NIR_avg*20);

RGB_I1   = RGB_I * 10^4;
NIR_I1   = NIR_avg * 10^4;
red_I1   = RGB_I1(:,:,1);
green_I1 = RGB_I1(:,:,2);
blue_I1  = RGB_I1(:,:,3);

%% down sample

[red_d,green_d,blue_d,NIR_d] = down_sample(red_O,green_O,blue_O,NIR_O);


%% gradient interpolation

red_I   = bicubic(red_d);
green_I = bicubic(green_d);
blue_I  = bicubic(blue_d);
NIR_I   = bicubic(NIR_d);
 

%% display the picture

RGB_O(1:1024,1:1024,1)=red_I(100:1123, 300:1323); %R
RGB_O(1:1024,1:1024,2)=green_I(100:1123, 300:1323); %G
RGB_O(1:1024,1:1024,3)=blue_I(100:1123, 300:1323); %B
imtool(RGB_O*20,'DisplayRange', [0 255]);

NIR_out(1:1024,1:1024)=NIR_I(100:1123, 300:1323); %NIR
imtool(NIR_out*20);

RGB_O1   = RGB_O * 10^4;
NIR_O1   = NIR_out * 10^4;
red_O1   = RGB_O1(:,:,1);
green_O1 = RGB_O1(:,:,2);
blue_O1  = RGB_O1(:,:,3);

%% calculate MSE, SNR and PSNR
[MSEr, SNRr, PSNRr] = Calc_MSE_SNR(red_O1,red_I1,0);
[MSEg, SNRg, PSNRg] = Calc_MSE_SNR(green_O1,green_I1,0);
[MSEb, SNRb, PSNRb] = Calc_MSE_SNR(blue_O1,blue_I1,0);
[MSEn, SNRn, PSNRn] = Calc_MSE_SNR(NIR_O1,NIR_I1,0);

