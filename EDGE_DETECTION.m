%inp_img = imread('/Users/suchethas/Desktop/NYU_Classes/SEM_2/Computer_Vision/Homework2/images-project2/shapes-bw.png');
inp_img = imread('/Users/suchethas/Desktop/NYU_Classes/SEM_2/Computer_Vision/Homework2/IMAGES/Chess-Board-1.jpg');
inp_img = rgb2gray(inp_img);
inp_img = imresize(inp_img,[373 373]);
size = 373
for i = 1:size
    for j = 1:size
       inp_img2(i,j)=inp_img(i,j);
    end
end
%--------------------------------------------------------------------------
% 3*3 SMOOTHING FILTER
for p = 2:size-1
    for q = 2:size-1
        sum = 0;
        for r = p-1:p+1
            for s = q-1:q+1
                sum = sum + double(inp_img(r,s));
            end
        end
        inp_img2(p,q)=sum/9;
    end
end

for k = 1:size
    for l = 1:size
       inp_imgx(k,l)=inp_img2(k,l);
       inp_imgy(k,l)=inp_img2(k,l);
       inp_img_gradient(k,l)=inp_img2(k,l);
       inp_img_orientation(k,l)=double(inp_img2(k,l));
    end
end
%--------------------------------------------------------------------------
% 1*3 AND 3*1 FILTERS
for u = 2:size-1
    for v = 2:size-1
        inp_imgx(u,v)=abs(double(inp_img2(u+1,v+1))-double(inp_img2(u+1,v)));
        inp_imgy(u,v)=abs(double(inp_img2(u+1,v+1))-double(inp_img2(u,v+1)));
        inp_img_gradient(u,v)=sqrt(double(inp_imgx(u,v)).^2+double(inp_imgy(u,v)).^2);
        if (inp_imgy(u,v) ==0 && inp_imgx(u,v) ==0)
            inp_img_orientation(u,v)= atand(0);
        else
            inp_img_orientation(u,v)= atand(double(inp_imgy(u,v))/double(inp_imgx(u,v)));
        end
    end
end
%--------------------------------------------------------------------------
% MAPPING INTENSITIES TO THE RANGE 0-255
row = 1;
col = 1;
for out = 2 : size-1
    for outp = 2 : size-1
        inp_img_orientation1(row,col)=inp_img_orientation(out,outp);
        col=col+1;
    end
    col=1;
    row=row+1;
end
col=1;
mi=min(min(inp_img_orientation1));
ma=max(max(inp_img_orientation1));
for su = 1:371
    for suc = 1:371
        inp_img_orientation1(su,suc)= (inp_img_orientation1(su,suc)-mi)/(ma-mi)*255;
    end 
end
figure(1);
subplot(3,2,1);imshow(inp_img);title('Input Image');
subplot(3,2,2);imshow(inp_img2);title('smoothed input image');
subplot(3,2,3);imshow(inp_imgx);title('x derivative');
subplot(3,2,4);imshow(inp_imgy);title('y derivative');
subplot(3,2,5);imshow(inp_img_gradient);title('edge map');
subplot(3,2,6);imshow(uint8(inp_img_orientation1));title('orientation map');