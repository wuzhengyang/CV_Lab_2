clear;
clc;
image=imread('lab2.jpg');
[width,height,z]=size(image);
if(z>1)
    image=rgb2gray(image);
end
figure(1);
set(gcf,'position',[200,200, 1300, 450])
%set(gcf,'position',[250,250, 900, 450])
%subplot(1,2,1);
subplot(1,3,1);
imshow(image);
title('原图');
av=0;
std=0.1;
u1=rand(width,height);
u2=rand(width,height);
x=std*sqrt(-2*log(u1)).*cos(2*pi*u2)+av;
G=double(image)/255+x;
G=uint8(255*G);

%subplot(1,2,2);
subplot(1,3,2);
imshow(G);
title('加高斯噪声后');

% %3x3均值滤波
% A = filter2(fspecial('average',3),G);
% result1 = uint8(A); 
% subplot(1,3,3);
% imshow(result1);
% title('均值滤波后');

%中值滤波
B = medfilt2(G);
result2 = uint8(B);
subplot(1,3,3);
imshow(result2);
title('中值滤波后');

%高斯滤波
sigma=8;%标准差大小 
window=double(uint8(3*sigma)*2+1);%窗口大小一半为3*sigma  
C=fspecial('gaussian',window,sigma);
result3 = uint8(imfilter(G,C,'replicate'));%为了不出现黑边，使用参数'replicate'
subplot(1,3,3);
imshow(result3);
title('高斯滤波后');
