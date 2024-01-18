function [ r,c ] = Centeroid_Points(A)
row=size(A,1);
col=size(A,2);
Area=FindArea(A);

area_val=0;
area_val2=0;

for i=1:row
    sum_val=0;
    for j=1:col
     if A(i,j)~=0
        sum_val=sum_val+1;
        y=j*1;
        area_val2=area_val2+y;
     end
    end
    x=i*sum_val;
    area_val=area_val+x;
end
r=round((1/Area)*(area_val));
c=round((1/Area)*(area_val2));



end

