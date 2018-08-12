InputImageMatrix = imread('/Users/suchethas/Desktop/NYU_Classes/SEM_2/Computer_Vision/IMAGES/CTscan.jpg');
TargetImageMatrix = imread('/Users/suchethas/Desktop/NYU_Classes/SEM_2/Computer_Vision/IMAGES/target.jpg')
InputGrayImage = rgb2gray(InputImageMatrix);
InputGrayImageResize = imresize(InputGrayImage,[128 128]);
TargetGrayImage = rgb2gray(TargetImageMatrix);
TargetGrayImageResize = imresize(TargetGrayImage,[128 128]);
[r c] = size(InputGrayImageResize);

%Computing the histogram of input and target images
InputHistogram=zeros(1,256);
TargetHistogram=zeros(1,256);
for p = 1:c
    for q = 1:r
        input_intensity=impixel(InputGrayImageResize,p,q);
        InputHistogram(input_intensity(1)+1)=(InputHistogram(input_intensity(1)+1)+1)
        target_intensity = impixel(TargetGrayImageResize,p,q);
        TargetHistogram(target_intensity(1)+1)=(TargetHistogram(target_intensity(1)+1)+1)
    end
end

%Computing the PDF of input and target images
InputPDF=zeros(1,256);
TargetPDF=zeros(1,256);
for i =1:256
    InputPDF(i)=InputHistogram(i)/16384
    TargetPDF(i)=TargetHistogram(i)/16384
end

%Computing the CDF of input and target images
inputCDF=[];
targetCDF=[];
inputCDF(1)=InputPDF(1);
targetCDF(1)=TargetPDF(1);
for ct = 2:256
    inputCDF(ct)=inputCDF(ct-1)+InputPDF(ct);
    targetCDF(ct)=targetCDF(ct-1)+TargetPDF(ct);
end

%Histogram Matching
M = zeros(1,256);
for idx = 1 : 256
    [~,ind] = min(abs(inputCDF(idx) - targetCDF));
    M(idx) = ind-1;
end

%Mapping the input image with M (Histogram matching Lookup) to get output
%image
for col = 1:128
    for row = 1:128
       outputimage(row,col)=M(InputGrayImageResize(row,col)+1);
    end 
end

%Computing the histogram output image
OutputHistogram=zeros(1,256);
for m = 1:c
    for n = 1:r
        output_intensity=impixel(outputimage,m,n);
        OutputHistogram(output_intensity(1)+1)=(OutputHistogram(output_intensity(1)+1)+1)
    end
end

%Computing the PDF of output image
OutputPDF=zeros(1,256);

for e =1:256
    OutputPDF(e)=OutputHistogram(e)/16384
end

%Computing the CDF of outputimage
OutputCDF=[];
OutputCDF(1)=OutputPDF(1);
for f = 2:256
    OutputCDF(f)=OutputCDF(f-1)+OutputPDF(f);
end

%Displaying
figure(1);
subplot(4,3,1);(imshow(InputGrayImageResize));
subplot(4,3,4);(bar(InputHistogram));
subplot(4,3,5);(bar(InputPDF));
subplot(4,3,6);(bar(inputCDF));
subplot(4,3,7);(imshow(outputimage,[0 255]));
subplot(4,3,10);(bar(OutputHistogram));
subplot(4,3,11);(bar(OutputPDF));
subplot(4,3,12);(bar(OutputCDF));


