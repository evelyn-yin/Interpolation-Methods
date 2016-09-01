function [p_1] = bilinear(p)

%p = video451_down_red;
[m,n] = size(p);
p_1 = zeros(m*2,n*2);

%% fill in the orginal image
for i = 1:1:m
    for j = 1:1:n
        p_1(i*2-1,j*2-1) = p(i,j);
    end
end

%% interpolation
for i = 1:2:m*2-2
    for j = 1:2:n*2-2
        p_1(i+1,j)   = 0.5  * (p_1(i,j)+p_1(i+2,j));
        p_1(i,j+1)   = 0.5  * (p_1(i,j)+p_1(i,j+2));
        p_1(i+1,j+1) = 0.25 * (p_1(i,j)+p_1(i+2,j)+p_1(i,j+2)+p_1(i+2,j+2));
    end
end

%% boundary
i = m*2-1;
for j = 2:2:n*2-2
    p_1(i,j) = 0.5 * (p_1(i,j-1)+p_1(i,j+1));
end
j = n*2-1;
for i = 2:2:m*2-2
    p_1(i,j) = 0.5 * (p_1(i-1,j)+p_1(i+1,j));
end

% i = m*2;
% for j = 1:1:n*2
%     p_1(i,j) = p_1(i-1,j);
% end
% 
% j = n*2;
% for i = 1:1:m*2
%     p_1(i,j) = p_1(i,j-1);
% end

i = m*2;
for j = 1:1:n*2
    p_1(i,j) = 0.5 * (p_1(i-1,j)+p_1(i-2,j));
end

j = n*2;
for i = 1:1:m*2
    p_1(i,j) = 0.5 * (p_1(i,j-1)+p_1(i,j-2));
end

%% plot the figure
% figure;
% imshow(p_1(:,:),[]);
% title('bilinear');