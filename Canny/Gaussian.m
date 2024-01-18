function [ Arr ] = Gaussian(A)
%A=imread('puma.jpg');
x=size(A,1);
y=size(A,2);
%J = rgb2gray(A); %make it into 2D matrix
%figure,imshow(J,[]);
res=zeros(x,y);
%mask=[2/115 4/115 5/115 4/115 2/115;4/115 9/115 12/115 9/115 4/115;5/115 12/115 15/115 12/115 5/115; 4/115 9/115 12/115 9/115 4/115;2/115 4/115 5/115 4/115 2/115];
mask=[2, 4, 5, 4, 2; 4, 9, 12, 9, 4;5, 12, 15, 12, 5;4, 9, 12, 9, 4;2, 4, 5, 4, 2 ];
mask = 1/159.* mask;
res=A;
i=1;
while(i<x+1)
    j=1;
    while(j<y+1)
        if (i<x-4 && j<y-4)
            dotProduct=0;sum=0;
            rIndex=i;
            for p=1:size(mask,1)
                colIndex=j;
                for k=1:size(mask,2)
                    dotProduct=mask(p,k)*res(rIndex,colIndex);
                    sum=sum + dotProduct;
                    colIndex=colIndex+1;
                end
                rIndex=rIndex+1;
            end
        end
        %dotProduct=(mask(1,1)*res(i,j)) + (mask(1,2)*res(i,j+1)) + (mask(1,3)*res(i,j+2)) + (mask(2,1)*res(i+1,j)) + (mask(2,2)*res(i+1,j+1)) + (mask(2,3)*res(i+1,j+2)) + (mask(3,1)*res(i+2,j)) + (mask(3,2)*res(i+2,j+1)) + (mask(3,3)*res(i+2,j+2));
        Arr(i,j)=sum;
        j=j+1;
    end
    i=i+1;
end
%%Arr = uint8(Arr);
%figure,imshow(Arr,[]);