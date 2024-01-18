function [maxThresh,bw] = OTSU2(I)
%I=imread('harewood.jpg'); 
%figure(1),imshow(I);
row=size(I,1);
col=size(I,2);
if (size(I,3)==3)
    I=rgb2gray(I);
end
%I=rgb2gray(I);
figure(2),imhist(I);
n=imhist(I);
N=sum(n);
max=0; 
for i=1:256
    P(i)=n(i)/N; %%har ek intensity level ki probability nikaalo
end

for j=2:255      %% baari baari saaray threholds k liye check kro
    %% 2 hisso mei divide kro code ko ek j se pehle wala sum aur ek j k baad wala sum
    w0=sum(P(1:j)); %%pehle wala sum
    
    
    w1=sum(P(j+1:256)); %%baad wala sum
    
    u0=dot([0:j-1],P(1:j))/w0;  %%%pehle waalay ka mean nikaalo
    
    u1=dot([j:255],P(j+1:256))/w1; %%baad walay ko mean nikaalo
    sigma=w0*w1*((u1-u0)^2); %%phir un dono means k saath variance compute kro
    if sigma>max %%ab maximum allot krna hai
        max=sigma; %%yahan max variance mil gyi
        threshold=j-1; %%jahan max hoi udhar ki gray level value pakro (j-1 isliye because 2 se start kiya hai isliye)
    end
end
maxThresh=threshold;
bw=im2bw(I,threshold/255); %%ab blacknw mei convert kro image ko
%figure(3),imshow(bw); 