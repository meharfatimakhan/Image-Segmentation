function [ row_p,col_p ] = Projectiionz(A)
row=size(A,1);
col=size(A,2);

row_p=zeros(1,row);
col_p=zeros(1,col);

for i=1:row
    count=0;
    for j=1:col
        if A(i,j)~=0
        count=count+1;
        end
    end
    row_p(1,i)=count;
end

for i=1:col
    count=0;
    for j=1:row
        if A(j,i)~=0
        count=count+1;
        end
    end
    col_p(1,i)=count;
end


end

