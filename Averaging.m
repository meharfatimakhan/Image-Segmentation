function [meanArr] = Averaging(I,row,col)
%I=imread('puma.jpg');
%figure,imshow(I);
x=size(I,1);
y=size(I,2);
z=size(I,3);
res=I;
specifiedRow=row;
specifiedCol=col;
rowFactor=ceil(x/specifiedRow);
colFactor=ceil(y/specifiedCol);
maskSize=rowFactor*colFactor;
%mask=zeros(maskSize,1,z);
mask=zeros(ceil(specifiedRow/rowFactor),ceil(specifiedCol/colFactor),z);
meanArr=zeros(ceil(specifiedRow/rowFactor),ceil(specifiedCol/colFactor),z);

p=1;
for i=2:rowFactor:x
    k=1;
    for j=2:colFactor:y
        if (i<x && j<y)
            maskIndex=1;sum1=0;countR=0;
            while (countR<rowFactor) 
                rIndex=i; countC=0;
                cIndex=j;
                while (countC<colFactor) 
                    computedMod=mod(colFactor,cIndex);
                    mask(maskIndex,1,:)=res(rIndex-1, cIndex-1 + computedMod);
                    sum1=sum1+mask(maskIndex,1,:);
                    maskIndex=maskIndex+1;
                    countC=countC+1;
                    cIndex=cIndex+1;
                end
                rIndex=rIndex+1;
                countR=countR+1;
            end
            meanArr(p,k,:)=sum1/maskSize;
%             mask(1,1,:)=res(i-1,j-1,:);
%             mask(2,1,:)=res(i-1,j,:);
%             mask(3,1,:)=res(i-1,j+1,:);
%             mask(4,1,:)=res(i,j-1,:);
%             mask(5,1,:)=res(i,j,:);
%             mask(6,1,:)=res(i,j+1,:);
%             mask(7,1,:)=res(i+1,j-1,:);
%             mask(8,1,:)=res(i+1,j,:);
%             mask(9,1,:)=res(i+1,j+1,:);
%             meanArr(p,k,:)=(mask(1,1,:)+mask(2,1,:)+mask(3,1,:)+mask(4,1,:)+mask(5,1,:)+mask(6,1,:)+mask(7,1,:)+mask(8,1,:)+mask(9,1,:))/9;
        end
        k=k+1;
    end
    p=p+1;
end

meanArr = uint8(meanArr);
figure,imshow(meanArr,[]);
