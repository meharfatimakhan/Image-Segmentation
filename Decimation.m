function [decimation] = Decimation(I,row,col,antialias)
%I=imread('puma.jpg');
%antialias=1;
x=size(I,1);
y=size(I,2);
z=size(I,3);
p=1;
res=I;
%figure,imshow(res);
meanArr=zeros(x,y,z);
mask=zeros(9,1,z);
for i=2:x+1
    k=1;
    for j=2:y+1
        if (i<x && j<y)
            mask(1,1,:)=res(i-1,j-1,:);
            mask(2,1,:)=res(i-1,j,:);
            mask(3,1,:)=res(i-1,j+1,:);
            mask(4,1,:)=res(i,j-1,:);
            mask(5,1,:)=res(i,j,:);
            mask(6,1,:)=res(i,j+1,:);
            mask(7,1,:)=res(i+1,j-1,:);
            mask(8,1,:)=res(i+1,j,:);
            mask(9,1,:)=res(i+1,j+1,:);
            meanArr(p,k,:)=(mask(1,1,:)+mask(2,1,:)+mask(3,1,:)+mask(4,1,:)+mask(5,1,:)+mask(6,1,:)+mask(7,1,:)+mask(8,1,:)+mask(9,1,:))/9;
        end  
            k=k+1;
    end
         p=p+1;  
end
meanArr = uint8(meanArr);
if (antialias==1)
    I=meanArr;
end
 %I=meanArr;
%figure,imshow(meanArr);
specifiedRow=128;
specifiedCol=128;
rowFactor=ceil(x/specifiedRow);
colFactor=ceil(y/specifiedCol);
p=1;
decimation=zeros(ceil(specifiedRow/rowFactor),ceil(specifiedCol/colFactor),z);
for i=1:rowFactor:x
    k=1;
    for j=1:colFactor:y
        if (i<x && j<y)
            decimation(p,k,:)=I(i,j,:);  
        end
        k=k+1;
    end
     p=p+1;
 end

decimation = uint8(decimation);
figure,imshow(decimation,[]);
