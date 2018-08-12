input = imread('/Users/suchethas/Desktop/NYU_Classes/SEM_2/Computer_Vision/Homework2/images-project2/shapes-bw.png');
template = imread('/Users/suchethas/Desktop/NYU_Classes/SEM_2/Computer_Vision/Homework2/images-project2/s.jpg');
input = rgb2gray(input);
template = rgb2gray(template);
input = imresize(input,[256 256]);
template = imresize(template,[41 41]);
inp_size = 256;
temp_size = 41;
temp_mean=0.0;
temp_norm = 0.0;
lap = [0.0 -1.0 0.0; -1.0 4.0 -1.0; 0.0 -1.0 0.0];
%--------------------------------------------------------------------------
for x = 1:inp_size
    for y = 1:inp_size
       input2(x,y)=double(input(x,y));
       input3(x,y)=double(input(x,y));
       output_lap(x,y)=double(input(x,y));
    end
end
%--------------------------------------------------------------------------
% FINDING TEMPLATE MEAN AND TEMPLATE NORM
for i = 1:temp_size
    for j = 1:temp_size
        temp_mean = temp_mean + double(template(i,j));
        template_zero_mean(i,j)=0;
    end
end
temp_mean = temp_mean / (41*41);
for k = 1:temp_size
    for l = 1:temp_size
        template_zero_mean(k,l)=double(template(k,l))-temp_mean;
        temp_norm = temp_norm + double(template_zero_mean(k,l) .^ 2);
    end
end
temp_norm = double(sqrt(temp_norm));
%--------------------------------------------------------------------------
% NORMALIZED AUTO CORRELATION
for p = 21:inp_size-20
    for q = 21:inp_size-20
        sum = 0.0;
        for r = p-20:p+20
            for s = q-20:q+20
                sum = sum + double(input(r,s));
            end
        end
        image_norm = 0.0;
        for ai = p-20:p+20
            for bi = q-20:q+20
                input2(ai,bi) = double(input(ai,bi)) - double(sum/1681);
                image_norm = image_norm + double(input2(ai,bi) .^ 2);
            end
        end
        image_norm = sqrt(image_norm);
        m=0;
        n=0;
        sum1=0.0;
        for t = p-20:p+20
            m=m+1;
            for u = q-20:q+20
                n=n+1;
                if (image_norm ==0 )
                    sum1=0;
                else
                    sum1 = sum1 + double((double(input2(t,u))*template_zero_mean(m,n))/((image_norm)*(temp_norm)));
                end
            end
            n=0;
        end
        m=0;
        input3(p,q)=(sum1);
     end
end
%--------------------------------------------------------------------------
%THRESHOLD
ro = 1;
co = 1;
for out = 21:237
    for outp = 21:237
        if input3(out,outp)<0.7 
            normalized(ro,co)= 0;
        else
            normalized(ro,co)=input3(out,outp);
        end
        co=co+1;
    end
    co=1;
    ro=ro+1;
end
co=1;
%--------------------------------------------------------------------------
% LAPLACIAN 
for a1=21:(inp_size-20)
    for a2=21:(inp_size-20)
        sum2=0;
        c1=0;
        c2=0;
        for b1=a1-1:a1+1
            c1 = c1+ 1;
            for b2=a2-1:a2+1
                c2 = c2+1;
                sum2 = sum2 + double(double(input3(b1,b2) * lap(c1,c2)));
                
            end
            c2=0;
        end
        c1=0;
        output_lap(a1,a2) = sum2;
    end
end
%--------------------------------------------------------------------------
% MAPPING INTENSITIES TO THE RANGE 0-255
row = 1;
col = 1;
for out = 22 : 235
    for outp = 22 : 235
        output_lap1(row,col)=output_lap(out,outp);
        col=col+1;
    end
    col=1;
    row=row+1;
end
col=1;
mi=min(min(output_lap1));
ma=max(max(output_lap1));
thresh=zeros([214 214]);
for su = 1:214
    for suc = 1:214
        output_lap1(su,suc)= (output_lap1(su,suc)-mi)/(ma-mi)*255;
        if output_lap1(su,suc)>140
            thresh(su,suc)=output_lap1(su,suc);
        end
    end 
end
%--------------------------------------------------------------------------
thresh=uint8(thresh);
output_lap1=uint8(output_lap1);
figure(1);
subplot(3,2,1);imshow(input);title('Input Image');
subplot(3,2,2);imshow(template);title('Template to be matched');
subplot(3,2,3);imshow(input3);title('correlation image');
subplot(3,2,4);imshow(normalized);title('Threshold (correlation)');
subplot(3,2,5);imshow(output_lap1);title('Laplacian peak detected image');
subplot(3,2,6);imshow(thresh);title('Threshold (Laplacian)');