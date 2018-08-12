%inp_img = imread('/Users/suchethas/Desktop/NYU_Classes/SEM_2/Computer_Vision/Homework2/IMAGES/Chess-Board.jpg');
inp_img = imread('/Users/suchethas/Desktop/NYU_Classes/SEM_2/Computer_Vision/Homework2/images-project2/text.png');
inp_img = rgb2gray(inp_img);
inp_img = imresize(inp_img,[373 373]);
[r1 c1]=size(inp_img)

% 3*3 smoothing
for i = 1:r1
    for j = 1:c1
       out3(i,j)=inp_img(i,j);
       out5(i,j)=inp_img(i,j);
    end
end
for p = 2:r1-1
    for q = c1-1
        sum = 0;
        for r = p-1:p+1
            for s = q-1:q+1
                sum = sum + double(inp_img(r,s));
            end
        end
        out3(p,q)=sum/9;
    end
end

% 5*5 smoothing
for p = 3:r1-2
    for q = 3:c1-2
        sum1 = 0;
        for r = p-2:p+2
            for s = q-2:q+2
                sum1 = sum1 + double(inp_img(r,s));
            end
        end
        out5(p,q)=sum1/25;
    end
end
figure(1);
subplot(1,3,1);imshow(inp_img);title('Input Image');
subplot(1,3,2);imshow(out3);title('3*3 smoothing filter');
subplot(1,3,3);imshow(out5);title('5*5 smoothing filter');