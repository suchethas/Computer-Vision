ImageMatrix=imread('/Users/suchethas/Desktop/NYU_Classes/SEM_2/Computer_Vision/IMAGES/WashingtonSquarePark.JPG');
grayImage=rgb2gray(ImageMatrix); %Converting image to grayscale
grayResize = imresize(grayImage,[256 256]); %Resizing the image to 256*256
prompt = 'Enter the number of bins :';
bins = input(prompt)
[r c]=size(grayResize);
result=zeros(1,256);%default bin size is 256 and is stored in result as 1D array
result2=zeros(1,bins);%user specifice bin size o/p is stored in result2 as 1D array
for p = 1:c
    for q = 1:r
        intensity=impixel(grayResize,p,q);
        result(intensity(1)+1)=result(intensity(1)+1)+1;
    end
end
j=round(256/bins)
sum=0
t=0
a=1
for r = 1:bins
    if ((a+j)-1)>=256 || t+1==bins
        for s=a:256
            sum=sum+result(s)
        end
    else
        
        for s = a:((a+j)-1)
            sum=sum+result(s)
        end
    end
    a=a+j
    t=t+1
    result2(t)=sum
    sum=0
end
%Computing PDF for default bin size
pdf_result=zeros(1,256);
for st = 1:256
    %pdf_result2(st)=(result2(st)/65536)/j
    pdf_result(st)=result(st)/65536
end
%Computing PDF for user defined bin size
pdf_result2=zeros(1,bins);
for i = 1:bins
    pdf_result2(i)=(result2(i)/65536);
end

%Computing CDF for default bin size
result_cdf=zeros(1,256);
result_cdf(1)=pdf_result(1);
for ct = 2:256
    result_cdf(ct)=result_cdf(ct-1)+pdf_result(ct)
end
%Computing CDF for user defined bin size
result_cdf2=zeros(1,bins);
result_cdf2(1)=pdf_result2(1);
for j=2:bins
    result_cdf2(j)=result_cdf2(j-1)+pdf_result2(j);
end
%Displaying all the graphs
figure(1);
subplot(3,3,2);(imshow(grayResize));
subplot(3,3,4);(bar(result));
subplot(3,3,5);(bar(pdf_result));
subplot(3,3,6);(bar(result_cdf));
subplot(3,3,7);(bar(result2));
subplot(3,3,8);(bar(pdf_result2));
subplot(3,3,9);(bar(result_cdf2));