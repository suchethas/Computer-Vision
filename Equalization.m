ImageMatrix=imread('/Users/suchethas/Desktop/NYU_Classes/SEM_2/Computer_Vision/IMAGES/crowd.png');
grayImage=rgb2gray(ImageMatrix);
grayResize = imresize(grayImage,[128 128]);
%Computing Histogram of the image
[r c]=size(grayResize);
result=zeros(1,256);
result_new=zeros(1,256);
for p = 1:c
    for q = 1:r
        intensity=impixel(grayResize,p,q);
        result(intensity(1)+1)=(result(intensity(1)+1)+1)
    end
end
%Computing PDF
result_pdf=zeros(1,256);
for st = 1:256
    result_pdf(st)=result(st)/16384
end
%Computing CDF
result_ct=zeros(1,256);
result_ct(1)=result_pdf(1)
for ct = 2:256
    result_ct(ct)=result_ct(ct-1)+result_pdf(ct)
end
%Equalization
result_eq=zeros(1,256);
for ab =1:256
    result_eq(ab)=round(255*result_ct(ab))
end
%Generating equalized image
new_img=[]%=zeros(256,256)
for col = 1:128
    for ro = 1:128
        new_img(ro,col)=result_eq(grayResize(ro,col)+1)
    end
end
%Computing Histogram of new image
for p = 1:c
    for q = 1:r
        intensity1=impixel(new_img,p,q);
        result_new(intensity1(1)+1)=(result_new(intensity1(1)+1)+1)
    end
end
%Computing PDF
result_new_pdf=zeros(1,256);
for st = 1:256
    result_new_pdf(st)=result_new(st)/16384
end
%Computing CDF
result_ct_new=zeros(1,256);
result_ct_new(1)=result_new_pdf(1)
for ct = 2:256
    result_ct_new(ct)=result_ct_new(ct-1)+result_new_pdf(ct)
end
figure(1);
subplot(4,3,1);(imshow(grayResize));
subplot(4,3,4);(bar(result));
subplot(4,3,5);(bar(result_pdf));
subplot(4,3,6);(bar(result_ct));
subplot(4,3,7);(imshow(new_img,[0 255]));
subplot(4,3,10);(bar(result_new));
subplot(4,3,11);(bar(result_new_pdf));
subplot(4,3,12);(bar(result_ct_new));
