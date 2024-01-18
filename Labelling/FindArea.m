function [ Area ] = FindArea(A)
S=size(A);
row=S(1);
col=S(2);
Area_count=0;

for i=1:row
   for j=1:col
   
   if A(i,j)~=0
   Area_count=Area_count+1;
   end
       
   end
end
Area=Area_count;
end

