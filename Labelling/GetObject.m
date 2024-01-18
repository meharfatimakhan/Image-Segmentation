function [ Arr ] = GetObject( A,obj_num)

S=size(A);
row=S(1);
col=S(2);
Arr=zeros(row,col);

for i=1:row
    for j=1:col
    
    if A(i,j)==obj_num
    
        Arr(i,j)=A(i,j);
        
    end
    
    end

end




end

