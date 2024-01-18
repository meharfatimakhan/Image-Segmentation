function [medianArr] = Median(I, row, col)
%I=imread('vision.png');
%I = imnoise(I,'salt & pepper',0.02);
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
mask=zeros(maskSize,1,z);
medianArr=zeros(specifiedRow/rowFactor,specifiedCol/colFactor,z);
p=1;
for i=2:rowFactor:x
    k=1;
    for j=2:colFactor:y
        if (i<x && j<y)
            maskIndex=1;countR=0;
            while (countR<rowFactor) 
                rIndex=i; countC=0;
                cIndex=j;index1=0;index2=0;
                while (countC<colFactor) 
                    computedMod=mod(colFactor,cIndex);
                    mask(maskIndex,1,:)=res(rIndex-1, cIndex-1 + computedMod);
                    maskIndex=maskIndex+1;
                    countC=countC+1;
                    cIndex=cIndex+1;
                end
                rIndex=rIndex+1;
                countR=countR+1;
            end
            
            mask=sort(mask);
            if (mod(maskSize,2)==0)
                index1=ceil(maskSize/2);
                index2=ceil((maskSize/2)+1);
                medianArr(p,k,:)=ceil((mask(index1,1,:)+mask(index2,1,:))/2);
            else
                index1=ceil(maskSize/2);
                medianArr(p,k,:)=mask(index1,1,:);

            end
            medianArr(p,k,:)=mask(5,1,:);
%             mask(1,1,:)=res(i-1,j-1,:);
%             mask(2,1,:)=res(i-1,j,:);
%             mask(4,1,:)=res(i,j,:);
%             mask(3,1,:)=res(i-1,j+1,:);
%             mask(4,1,:)=res(i,j-1,:);
%             mask(5,1,:)=res(i,j,:);
%             mask(6,1,:)=res(i,j+1,:);
%             mask(7,1,:)=res(i+1,j-1,:);
%             mask(8,1,:)=res(i+1,j,:);
%             mask(9,1,:)=res(i+1,j+1,:);     
%             medianArr(p,k,:)=mask(5,1,:);
        end
        k=k+1;
    end
    p=p+1;
end

medianArr = uint8(medianArr);
%figure,imshow(medianArr,[]);
