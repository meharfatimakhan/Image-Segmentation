function [ Arr ] = updateValue( Array,v1,v2)
%v1=value to change
%v2 used value for change

Arr=Array;
S=size(Arr);
row=S(1);
col=S(2);

for i=1:row
    for j=1:col
    if Arr(i,j)==v1
       
        Arr(i,j)=v2;
    
    end
    
    end
end



end

