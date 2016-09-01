%clc; clear
%load('K.mat')
p  = red_0(1:2:end,1:2:end);
th = 1.1;
A  = [1/2 1/4 1/8 1/16];
B  = [0 2 0 0; -1 0 1 0; 2 -5 4 -1; -1 3 -3 1];
[M,N] = size(p);
p_0 = p;
p_1 = zeros(M*2,N*2);

%% fill in the orginal image
for i=1:2:2*M-1
    for j=1:2:2*N-1
        p_1(i,j)=p(ceil(i/2),ceil(j/2));
	end
end

%% Compute gradients across every directions

%% compute 135 and 45
for i=4:2:2*M-4
    for j=4:2:2*N-4
        
		D45(i,j)=0;
		D135(i,j)=0;

       %%45 degree             
       for m=-3:2:1
			for n=-1:2:3
				diff45=abs(p_1(i+m,j+n) - p_1(i+m+2,j+n-2));
%               a1(4+m,2+n)=i+m; a2(4+m,2+n)=j+n; b1(4+m,2+n)=i+m+2;b2(4+m,2+n)= j+n-2;  
				D45(i,j)= D45(i,j) + diff45;
			end
       end
       
       %%135 degree
       for m=-3:2:1
			for n=-3:2:1
                diff135=abs(p_1(i+m,j+n) - p_1(i+m+2,j+n+2));
% 				a1(4+m,4+n)=i+m; a2(4+m,4+n)=j+n; b1(4+m,4+n)=i+m+2;b2(4+m,4+n)= j+n+2;
                D135(i,j)=D135(i,j) + diff135;
			end
       end
       
       %ratio
        R(i,j)=D45(i,j)/D135(i,j);
        L(i,j)=D135(i,j)/D45(i,j);
        

    end
end

%% interpolation
for i=4:2:2*M-4
    for j=4:2:2*N-4
        
         if(R(i,j)>th)
             p_1(i,j) = A * B * [p_1(i-3,j-3) p_1(i-1,j-1) p_1(i+1,j+1) p_1(i+3,j+3)]';
                      
         elseif(L(i,j)>th) 
             p_1(i,j) = A * B * [p_1(i+3,j-3) p_1(i+1,j-1) p_1(i-1,j+1) p_1(i-3,j+3)]';

         else
             p_1(i,j) = (p_1(i-1,j-1) + p_1(i+1,j-1) + p_1(i-1,j+1) + p_1(i+1,j+1))/4;

         end
    end
end


%% compute 0 and 90 (horizontally)
for i=4:2:2*M-5
    for j=5:2:2*N-5
        
		D0(i,j)=0;
		D90(i,j)=0;
                
        %%0 degree
       for m=-2:2:2
			for n=-1:2:3
				diff0=abs(p_1(i+m,j+n) - p_1(i+m,j+n-2));
%               a1(3+m,2+n)=i+m; a2(3+m,2+n)=j+n; b1(3+m,2+n)=i+m;b2(3+m,2+n)= j+n-2; 
				D0(i,j)=D0(i,j) + diff0;
			end
       end
       
       %%90 degree      
       for m=-1:2:3
			for n=-2:2:2
				diff90=abs(p_1(i+m,j+n) - p_1(i+m-2,j+n));
%               a1(2+m,3+n)=i+m; a2(2+m,3+n)=j+n; b1(2+m,3+n)=i+m-2;b2(2+m,3+n)= j+n;
				D90(i,j)=D90(i,j) + diff90;
			end
       end
       
        %ratio
        H(i,j)=D0(i,j)/D90(i,j);
        V(i,j)=D90(i,j)/D0(i,j);
    end
end

%% interpolation
for i=4:2:2*M-5
    for j=5:2:2*N-5
        
         if(H(i,j)>th)
             p_1(i,j) = A * B * [p_1(i-3,j) p_1(i-1,j) p_1(i+1,j) p_1(i+3,j)]';
                      
         elseif(V(i,j)>th) 
             p_1(i,j) = A * B * [p_1(i,j-3) p_1(i,j-1) p_1(i,j+1) p_1(i,j+3)]';

         else
             p_1(i,j) = (p_1(i,j-1) + p_1(i,j+1) + p_1(i-1,j) + p_1(i+1,j))/4;

         end
    end
end


%% compute 0 and 90 (vertically)

for i=5:2:2*M-5
    for j=4:2:2*N-5
        
		D0(i,j)=0;
		D90(i,j)=0;    
        
       %%0 degree      
       for m=-2:2:2
			for n=-1:2:3
				diff0=abs(p_1(i+m,j+n) - p_1(i+m,j+n-2));
%               a1(3+m,2+n)=i+m; a2(3+m,2+n)=j+n; b1(3+m,2+n)=i+m;b2(3+m,2+n)= j+n-2; 
				D0(i,j)=D0(i,j) + diff0;
			end
       end
       
       %%90 degree      
       for m=-1:2:3
			for n=-2:2:2
				diff90=abs(p_1(i+m,j+n) - p_1(i+m-2,j+n));
%               a1(2+m,3+n)=i+m; a2(2+m,3+n)=j+n; b1(2+m,3+n)=i+m-2;b2(2+m,3+n)= j+n;
				D90(i,j)=D90(i,j) + diff90;
			end
       end
       
        %ratio
        H(i,j)=D0(i,j)/D90(i,j);
        V(i,j)=D90(i,j)/D0(i,j);
    end
end

%% interpolation
for i=5:2:2*M-5
    for j=4:2:2*N-5
        
         if(H(i,j)>th)
             
              %p_1(i,j) = cbci_edge(p_1(i-3,j), p_1(i-1,j), p_1(i+1,j), p_1(i+3,j));
             p_1(i,j) = A * B * [p_1(i-3,j) p_1(i-1,j) p_1(i+1,j) p_1(i+3,j)]';
                      
         elseif(V(i,j)>th) 
            % p_1(i,j) = cbci_edge(p_1(i,j-3), p_1(i,j-1), p_1(i,j+1), p_1(i,j+3));
             p_1(i,j) = A * B * [p_1(i,j-3) p_1(i,j-1) p_1(i,j+1) p_1(i,j+3)]';

         else
             p_1(i,j) = (p_1(i,j-1) + p_1(i,j+1) + p_1(i-1,j) + p_1(i+1,j))/4;

         end
    end
end

