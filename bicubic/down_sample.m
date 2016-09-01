function [red_d,green_d,blue_d,NIR_d] = down_sample(red,green,blue,NIR)

red_d   = red(1:2:end,1:2:end);
green_d = green(1:2:end,1:2:end);
NIR_d   = NIR(1:2:end,1:2:end);
blue_d  = blue(1:2:end,1:2:end);

% %% plot the figures
% figure;
% imshow(red_d(:,:),[]);
% title('RED');
% 
% figure;
% imshow(green_d(:,:),[]);
% title('GREEN');
% 
% figure;
% imshow(NIR_d(:,:),[]);
% title('NIR');
% 
% figure;
% imshow(blue_d(:,:),[]);
% title('BLUE');