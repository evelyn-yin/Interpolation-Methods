function p_1 = bicubic(p)

% M  = rand(12,12)
% p  = M(1:2:end,1:2:end)
A  = [1/2 1/4 1/8 1/16];
B  = [0 2 0 0; -1 0 1 0; 2 -5 4 -1; -1 3 -3 1];

[m,n] = size(p);
p_0 = p;
p_1 = zeros(m*2,n*2);

%% fill in the orginal image
for i=1:2*m
    for j=1:2:2*n
        p_1(i,j)=p(ceil(i/2),ceil(j/2));
	end
end

%% interpolation 

% % 45
% for i=4:2:2*m-4
%     for j=4:2:2*n-4
%         p_1(i,j) = A * B * [p_1(i-3,j-3) p_1(i-1,j-1) p_1(i+1,j+1) p_1(i+3,j+3)]';
%     end
% end

%vertically

for i=4:2:2*m-5
    for j=5:2:2*n-5
        p_1(i,j) = A * B * [p_1(i-3,j) p_1(i-1,j) p_1(i+1,j) p_1(i+3,j)]';
    end
end

%horizontally
for i=5:1:2*m-5
    for j=4:2:2*n-5
        p_1(i,j) = A * B * [p_1(i,j-3) p_1(i,j-1) p_1(i,j+1) p_1(i,j+3)]';
    end
end

% %interpolation vertically
% for i = 2:2:m*2-5
%     for j = 1:1:n*2
%         p_1(i,j)   = A * B * [p_1(i-1,j) p_1(i,j) p_1(i+1,j) p_1(i+2,j)]';
%     end
% end
% % 
% % interpolation horizontally
% for j = 2:1:n*2-5
%     for i = 1:1:m*2
%         p_1(i,j)   = A * B * [p_1(i,j-1) p_1(i,j) p_1(i,j+1) p_1(i,j+2)]';
%     end
% end



% %interpolation vertically
% for i = 2:2:m*2-1
%     for j = 1:1:n*2
%         p_1(i,j)   = A * B * [p_1(i-1,j) p_1(i,j) p_1(i+1,j) p_1(i+2,j)]';
%     end
% end
% 
% % interpolation horizontally
% for j = 2:2:n*2-2
%     for i = 1:1:m*2
%         p_1(i,j)   = A * B * [p_1(i,j-1) p_1(i,j) p_1(i,j+1) p_1(i,j+2)]';
%     end
% end


%% boundary
for i = 1:1:m*2
    p_1(i,n*2) = 3*p_1(i,n*2-1) - 3 *p_1(i,n*2-2)+p_1(i,n*2-3);
end

for j = 1:1:n*2
    p_1(m*2,j) = 3*p_1(m*2-1,j) - 3 *p_1(m*2-2,j)+p_1(m*2-3,j);
end

% for j = 1:1:n*2
%     p_1(1,j) = 3*p_1(2,j) - 3 *p_1(3,j)+p_1(4,j);
% end
% 
% for i = 1:1:m*2
%     p_1(i,1) = 3*p_1(i,2) - 3 *p_1(i,3)+p_1(i,4);
% end
% 
% for j = 1:1:n*2
%     p_1(m*2-1,j) = 3*p_1(m*2,j) - 3 *p_1(m*2-2,j)+p_1(m*2-3,j);
% end
% 
% for i = 1:1:m*2
%     p_1(i,n*2-1) = 3*p_1(i,n*2) - 3 *p_1(i,n*2-2)+p_1(i,n*2-3);
% end
% 
% for j = 1:1:n*2
%     p_1(m*2-3,j) = 3*p_1(m*2-2,j) - 3 *p_1(m*2-4,j)+p_1(m*2-5,j);
% end
% 
% for i = 1:1:m*2
%     p_1(i,n*2-3) = 3*p_1(i,n*2-2) - 3 *p_1(i,n*2-4)+p_1(i,n*2-5);
% end