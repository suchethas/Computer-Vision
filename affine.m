inp_img = double(rgb2gray(imread('/Users/suchethas/Desktop/NYU_Classes/SEM_2/Computer_Vision/Project-2/T.jpeg')));
target_img = double(rgb2gray(imread('/Users/suchethas/Desktop/NYU_Classes/SEM_2/Computer_Vision/Project-2/T_rotate.jpeg')));
inp_img = imresize(inp_img,[300 300]);
target_img = imresize(target_img,[300 300]);
size= 300;
figure(1);
subplot(1,2,1);imshow(inp_img,[0 255]);
subplot(1,2,2);imshow(target_img,[0 255]);
% imshow(target_img,[0 255]);
hold on;
[x y] = ginput(6);
x = round(x);
y = round(y);
midx=ceil((size+1)/2);
midy=ceil((size+1)/2);
% x = [64.4522821576764;106.775933609959;247.439834024896;42.4003115264798;262.961059190031;92.8676012461059];
% y = [41.1120331950207;263.311203319502;92.1493775933609;243.490654205607;199.253894080997;62.1822429906542];
% x = [64;106;247;42;262;92];
% y = [41;263;92;243;199;62];
X_mat = [x(1) y(1) 1 0 0 0; 0 0 0 x(1) y(1) 1; x(2) y(2) 1 0 0 0; 0 0 0 x(2) y(2) 1; x(3) y(3) 1 0 0 0; 0 0 0 x(3) y(3) 1];
X_dash_mat = [x(4);y(4);x(5);y(5);x(6);y(6)];
A_mat = round(inv(X_mat) * X_dash_mat);
affine_mat = [A_mat(1) A_mat(2) 0; A_mat(4) A_mat(5) 0; 0 0 1];
affine_mat = inv(affine_mat);
% for i = 1:size
%     for j = 1:size
%         x_dash = [i; j; 1];
%         x1 = ceil(inv(affine_mat) * x_dash);
%         out_img(i,j) = inp_img(round(abs(x1(1,1))),round(abs(x1(2,1))));
%     end
% end
for i = 1:size
    for j = 1:size
        x_dash = [i-midx; j-midy; 1];
        x = inv(affine_mat) * x_dash;
        x_val = round(x(1,1))+midx;
        y_val = round(x(2,1))+midy;
        if (x_val>0 && x_val <=300 && y_val>0 && y_val <=300)
            out_img(i,j) = inp_img(x_val,y_val);
        end
    end
end
figure(1);
subplot(1,3,1);imshow(inp_img,[0 255]);title('input image');
subplot(1,3,2);imshow(target_img,[0 255]);title('target image');
subplot(1,3,3);imshow(out_img,[0 255]);title('output image');

