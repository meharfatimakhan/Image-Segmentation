function [edge_final] = Prewitt(A)
%A=imread('bricks.jpeg');
A=im2double(A);
A=Gaussian(A);
Arr1=PrewittH(A);
Arr2=PrewittV(A);
magnitude=zeros(size(A,1),size(A,2));
angle=zeros(size(A,1),size(A,2));

for i=1:size(A,1)
    for j=1:size(A,2)
        calSquare=(Arr1(i,j)*Arr1(i,j))+(Arr2(i,j)*Arr2(i,j));
        magnitude(i,j)=sqrt(calSquare);
        calAngle=(Arr2(i,j)/Arr1(i,j));
        arah=atan2(Arr2(i,j),Arr1(i,j));
        arah = arah*180/pi;
        angle(i,j)=arah;
    end
end
%converting angles to positive
for i=1:size(A,1)
   for j=1:size(A,2)
    if angle(i,j)<0 
       angle(i,j)=360+angle(i,j);
    end
   end
end

%rounding angles to nearest side 
angle2=zeros(size(A,1), size(A,2));
%Adjusting directions to nearest 0, 45, 90, or 135 degree
for i = 1  : size(A,1)
    for j = 1 : size(A,2)
        if ((angle(i, j) >= 0 ) && (angle(i, j) < 22.5) || (angle(i, j) >= 157.5) && (angle(i, j) < 202.5) || (angle(i, j) >= 337.5) && (angle(i, j) <= 360))
            angle2(i, j) = 0;
        elseif ((angle(i, j) >= 22.5) && (angle(i, j) < 67.5) || (angle(i, j) >= 202.5) && (angle(i, j) < 247.5))
            angle2(i, j) = 45;
        elseif ((angle(i, j) >= 67.5 && angle(i, j) < 112.5) || (angle(i, j) >= 247.5 && angle(i, j) < 292.5))
            angle2(i, j) = 90;
        elseif ((angle(i, j) >= 112.5 && angle(i, j) < 157.5) || (angle(i, j) >= 292.5 && angle(i, j) < 337.5))
            angle2(i, j) = 135;
        end
    end
end

Ns_arr=zeros(size(A,1),size(A,2));

for i=2:size(A,1)-1
    for j=2:size(A,2)-1
        if (angle2(i,j)==0)
            Ns_arr(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i,j+1), magnitude(i,j-1)]));
        elseif (angle2(i,j)==45)
            Ns_arr(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i+1,j-1), magnitude(i-1,j+1)]));
        elseif (angle2(i,j)==90)
            Ns_arr(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i+1,j), magnitude(i-1,j)]));
        elseif (angle2(i,j)==135)
            Ns_arr(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i+1,j+1), magnitude(i-1,j-1)]));
        end
    end
end


Ns_arr = Ns_arr.*magnitude;
figure, imshow(Ns_arr);
T_Low = 0.075;
T_High = 0.175;

T_Low = T_Low * max(max(Ns_arr));
T_High = T_High * max(max(Ns_arr));
T_res = zeros (size(A,1), size(A,2));
for i = 1  : size(A,1)
    for j = 1 : size(A,2)
        if (Ns_arr(i, j) < T_Low)
            T_res(i, j) = 0;
        elseif (Ns_arr(i, j) > T_High)
            T_res(i, j) = 1;
        %Using 8-connected components
        elseif ( Ns_arr(i+1,j)>T_High || Ns_arr(i-1,j)>T_High || Ns_arr(i,j+1)>T_High || Ns_arr(i,j-1)>T_High || Ns_arr(i-1, j-1)>T_High || Ns_arr(i-1, j+1)>T_High || Ns_arr(i+1, j+1)>T_High || Ns_arr(i+1, j-1)>T_High)
            T_res(i,j) = 1;
        end;
    end;
end;
edge_final = uint8(T_res.*255);
%Show final edge detection result
figure, imshow(edge_final);



%magnitude = uint8(magnitude);

%figure,imshow(angle,[]);
%figure,imshow(magnitude,[]);
%figure,imshow(Ns_arr,[]);
% angle = uint8(angle);
% figure,imshow(angle,[]);