input = double(imread('/Users/suchethas/Desktop/NYU_Classes/SEM_2/Computer_Vision/Project-2/mnn4-runway-Ohio.jpg'));
%input = rgb2gray(input);
input = imresize(input,[425 425]);
[row col] = size(input);

% APPLY 3*3 SMOOTHING FILTER (MEAN FILTER)
smoothed_input = double(zeros(row,col));
for p = 2:row-1
    for q = 2:col-1
        sum = 0.0;
        for r = p-1:p+1
            for s = q-1:q+1
                sum = sum + double(input(r,s));
            end
        end
        smoothed_input(p,q)=sum/9;
    end
end
%imshow(smoothed_input,[0 255])

% EDGE DETECTION (SOBEL FILTER)
input_x = double(zeros(row,col));
input_y = double(zeros(row,col));
edge_input = double(zeros(row,col));
for u = 2:row-1
    for v = 2:col-1
        input_x(u,v)=smoothed_input(u+1,v+1)-smoothed_input(u+1,v);
        input_y(u,v)=smoothed_input(u+1,v+1)-smoothed_input(u,v+1);
        edge_input(u,v)=sqrt(input_x(u,v).^2 + input_y(u,v).^2);
        if edge_input(u,v) < 20
            edge_input(u,v)=0;
        end
    end
end

% HOUGH 
max_dist = round(sqrt(row^2 + col^2));
%theta = -89:1:90;
theta = 1:1:180;
rho = -max_dist:1:max_dist;
H = zeros(length(rho),length(theta));
for a = 1:row
    for b = 1:col
        if edge_input(a,b)~= 0
            for index_theta = 1:length(theta)
                t = theta(index_theta)*pi/180;
                dist = a*cos(t) + b*sin(t);
                [d,index_rho] = min(abs(rho-dist));
                %if d <=1
                    H(index_rho,index_theta) = H(index_rho,index_theta) +1;
                %end
            end
        end
    end
end
% finding out the local maxima
[row1 col1]=size(H);
H = imgaussfilt(H,1);
H1 = islocalmax(H);
H1 = double(H1);
for val1=1:row1
    for val2=1:col1
        if H1(val1,val2)==1
            H1(val1,val2)=H(val1,val2);
        end
    end
end
[sortedValues,sortIndex] = sort(H1(:),'descend');
sortedValues = unique(H1(:));
maxValues = sortedValues(end-9:end);
maxIndex = ismember(H1,maxValues);

% Drawing back the lines 
subplot(1,1,1);
imshow(input,[0 255]);
hold on;
for ci = 1:row1
    for di = 1:col1
        if maxIndex(ci,di)==1
              
              y_val = round((rho(ci) - 425*cos(theta(di)))/sin(theta(di)));
              x_val = round((rho(ci) - 425*sin(theta(di)))/cos(theta(di)));
              x_arr = [425 x_val];
              y_arr = [y_val 425];
              plot(x_arr,y_arr,'*');
              hold on;
              line(x_arr,y_arr);
        end
    end
end


    
    
    
    
    
    
    
    
    