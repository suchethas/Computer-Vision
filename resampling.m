inp_img = double(rgb2gray(imread('/Users/suchethas/Desktop/NYU_Classes/SEM_2/Computer_Vision/Project-2/T.jpeg')));
inp_img = imresize(inp_img,[300 300]);
size = 300;
out_img = double(zeros(size,size));
midx=ceil((size+1)/2);
midy=ceil((size+1)/2);
%__________________________________________________________________________________
%NEAREST NEIGHBOUT ROTATION
% theta = 45;
% rotation = [ cosd(theta) -sind(theta) 0; sind(theta) cosd(theta) 0; 0 0 1];
% for i = 1:size
%     for j = 1:size
%         x_dash = [i-midx; j-midy; 1];
%         x = inv(rotation) * x_dash;
%         x_val = round(x(1,1))+midx;
%         y_val = round(x(2,1))+midy;
%         if (x_val>0 && x_val <=300 && y_val>0 && y_val <=300)
%             out_img(i,j) = inp_img(x_val,y_val);
%         end
%     end
% end
%__________________________________________________________________________________
% BILINEAR INTERPOLATION ROTATION
theta = 45;
rotation = [ cosd(theta) -sind(theta) 0; sind(theta) cosd(theta) 0; 0 0 1];
for i = 1:size
    for j = 1:size
        x_dash = [i-midx; j-midy; 1];
        x = inv(rotation) * x_dash;
        x_val = x(1,1)+midx;
        y_val = x(2,1)+midy;
        if (floor(x_val)==x_val && floor(y_val)==y_val && x_val>0 && x_val <=300 && y_val>0 && y_val <=300 )
            out_img(i,j) = inp_img(x_val,y_val);
        
        else
            x1 = floor(x_val);
            x2 = ceil(x_val);
            y1 = floor(y_val);
            y2 = ceil(y_val);
            if (x1>0 && x1 <=300 && x2>0 && x2<=300 && y1>0 && y1<=300 && y2>0 && y2<=300)
                f_r1 = (((x2-x_val)*inp_img(x1,y1))/(x2-x1)) + (((x_val-x1)*inp_img(x2,y1))/(x2-x1));
                f_r2 = (((x2-x_val)*inp_img(x1,y2))/(x2-x1)) + (((x_val-x1)*inp_img(x2,y2))/(x2-x1));
                out_img(i,j) = (((y2-y_val)*f_r1)/(y2-y1)) + (((y_val-y1)*f_r2)/(y2-y1));
            end
        end
    end
end
%__________________________________________________________________________________
% NN TRANSLATION
% translation = [ 1 0 25; 0 1 25; 0 0 1];
% for i = 1:size
%     for j = 1:size
%         x_dash = [i; j; 1];
%         x = inv(translation) * x_dash;
%         x_val = round(x(1,1));
%         y_val = round(x(2,1));
%         if (x_val>0 && x_val <=300 && y_val>0 && y_val <=300)
%             out_img(i,j) = inp_img(x_val,y_val);
%         
%         end
%     end
% end
%__________________________________________________________________________________
%BILINEAR INTERPOLATION TRANSLATION
% translation = [ 1 0 25; 0 1 25; 0 0 1];
% for i = 1:size
%     for j = 1:size
%         x_dash = [i-midx; j-midy; 1];
%         x = inv(translation) * x_dash;
%         x_val = x(1,1)+midx;
%         y_val = x(2,1)+midy;
%         if (floor(x_val)==x_val && floor(y_val)==y_val && x_val>0 && x_val <=300 && y_val>0 && y_val <=300 )
%             out_img(i,j) = inp_img(x_val,y_val);
%         
%         else
%             x1 = floor(x_val);
%             x2 = ceil(x_val);
%             y1 = floor(y_val);
%             y2 = ceil(y_val);
%             if (x1>0 && x1 <=300 && x2>0 && x2<=300 && y1>0 && y1<=300 && y2>0 && y2<=300)
%                 f_r1 = (((x2-x_val)*inp_img(x1,y1))/(x2-x1)) + (((x_val-x1)*inp_img(x2,y1))/(x2-x1));
%                 f_r2 = (((x2-x_val)*inp_img(x1,y2))/(x2-x1)) + (((x_val-x1)*inp_img(x2,y2))/(x2-x1));
%                 out_img(i,j) = (((y2-y_val)*f_r1)/(y2-y1)) + (((y_val-y1)*f_r2)/(y2-y1));
%             end
%         end
%     end
% end
%__________________________________________________________________________________
% NN SCALING
% scale = [ 1.5 0 0; 0 1.5 0; 0 0 1];
% for i = 1:size
%     for j = 1:size
%         x_dash = [i; j; 1];
%         x = inv(scale) * x_dash;
%         x_val = round(x(1,1));
%         y_val = round(x(2,1));
%         if (x_val>0 && x_val <=300 && y_val>0 && y_val <=300)
%             out_img(i,j) = inp_img(x_val,y_val);
%         
%         end
%     end
% end
%__________________________________________________________________________________
% BILINEAR INTERPOLATION SCALIING
% scale = [ 1.5 0 0; 0 1.5 0; 0 0 1];
% for i = 1:size
%     for j = 1:size
%         x_dash = [i-midx; j-midy; 1];
%         x = inv(scale) * x_dash;
%         x_val = x(1,1)+midx;
%         y_val = x(2,1)+midy;
%         if (floor(x_val)==x_val && floor(y_val)==y_val && x_val>0 && x_val <=300 && y_val>0 && y_val <=300 )
%             out_img(i,j) = inp_img(x_val,y_val);
%         
%         else
%             x1 = floor(x_val);
%             x2 = ceil(x_val);
%             y1 = floor(y_val);
%             y2 = ceil(y_val);
%             if (x1>0 && x1 <=300 && x2>0 && x2<=300 && y1>0 && y1<=300 && y2>0 && y2<=300)
%                 f_r1 = (((x2-x_val)*inp_img(x1,y1))/(x2-x1)) + (((x_val-x1)*inp_img(x2,y1))/(x2-x1));
%                 f_r2 = (((x2-x_val)*inp_img(x1,y2))/(x2-x1)) + (((x_val-x1)*inp_img(x2,y2))/(x2-x1));
%                 out_img(i,j) = (((y2-y_val)*f_r1)/(y2-y1)) + (((y_val-y1)*f_r2)/(y2-y1));
%             end
%         end
%     end
% end
%__________________________________________________________________________________
% NN SHEAR
% shear = [ 1 0.5 0; 0 1 0; 0 0 1];
% for i = 1:size
%     for j = 1:size
%         x_dash = [i; j; 1];
%         x = inv(shear) * x_dash;
%         x_val = round(x(1,1));
%         y_val = round(x(2,1));
%         if (x_val>0 && x_val <=300 && y_val>0 && y_val <=300)
%             out_img(i,j) = inp_img(x_val,y_val);
%         
%         end
%     end
% end
%__________________________________________________________________________________
% BILINEAR INTERPOLATION SHEAR
% shear = [ 1 0.5 0; 0 1 0; 0 0 1];
% for i = 1:size
%     for j = 1:size
%         x_dash = [i-midx; j-midy; 1];
%         x = inv(shear) * x_dash;
%         x_val = x(1,1)+midx;
%         y_val = x(2,1)+midy;
%         if (floor(x_val)==x_val && floor(y_val)==y_val && x_val>0 && x_val <=300 && y_val>0 && y_val <=300 )
%             out_img(i,j) = inp_img(x_val,y_val);
%         
%         else
%             x1 = floor(x_val);
%             x2 = ceil(x_val);
%             y1 = floor(y_val);
%             y2 = ceil(y_val);
%             if (x1>0 && x1 <=300 && x2>0 && x2<=300 && y1>0 && y1<=300 && y2>0 && y2<=300)
%                 f_r1 = (((x2-x_val)*inp_img(x1,y1))/(x2-x1)) + (((x_val-x1)*inp_img(x2,y1))/(x2-x1));
%                 f_r2 = (((x2-x_val)*inp_img(x1,y2))/(x2-x1)) + (((x_val-x1)*inp_img(x2,y2))/(x2-x1));
%                 out_img(i,j) = (((y2-y_val)*f_r1)/(y2-y1)) + (((y_val-y1)*f_r2)/(y2-y1));
%             end
%         end
%     end
% end
%__________________________________________________________________________________
% NEAREST NEIGHBOUR TRANSLATION, ROTATION, SCALING, SHEAR APPLIED TOGETHER
% shear = [ 1 0.5 0; 0 1 0; 0 0 1];
% theta = 15;
% rotation = [ cosd(theta) -sind(theta) 0; sind(theta) cosd(theta) 0; 0 0 1];
% translation = [ 1 0 5; 0 1 5; 0 0 1];
% scale = [1.1 0 0; 0 1.1 0; 0 0 1];
% for i = 1:size
%     for j = 1:size
%         x_dash = [i; j; 1];
%         x = inv(shear) * inv(translation) * inv(rotation) * inv(scale) * x_dash;
%         x_val = round(x(1,1));
%         y_val = round(x(2,1));
%         if (x_val>0 && x_val <=300 && y_val>0 && y_val <=300)
%             out_img(i,j) = inp_img(x_val,y_val);
%         
%         end
%     end
% end
%__________________________________________________________________________________ 
imshow(out_img,[0 255]);




