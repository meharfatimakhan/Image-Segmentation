function [ Arr, label_count] = Labelling(A)
S=size(A);
row=S(1);
col=S(2);

A=rgb2gray(A);
A=im2bw(A,0.5);
Arr=zeros(row,col);
label_count=1;
B=0;
C=0;
D=0;

for i=1:row
   for j=1:col
    if A(i,j)==0
    continue;  
    end
    if i~=1 && j~=1
     D=A(i-1,j-1);
    end
    if i~=1
     C=A(i-1,j);
    end
    if j~=1
     B=A(i,j-1);
    end
    if A(i,j)==D
      Arr(i,j)=Arr(i-1,j-1);
      continue;
    elseif A(i,j)==B
    
        if A(i,j)==C
           if Arr(i,j-1)==Arr(i-1,j);
              Arr(i,j)=Arr(i,j-1); 
           else
              val1=max(Arr(i,j-1),Arr(i-1,j));
              val2=min(Arr(i,j-1),Arr(i-1,j));
              Arr(i,j)=val2;
              Arr=updateValue(Arr,val1,val2);
              label_count=label_count-1;
           end
        else   
         Arr(i,j)=Arr(i,j-1); 
            
        end
        
    elseif A(i,j)==C
         
        Arr(i,j)=Arr(i-1,j);
        
    else
        Arr(i,j)=label_count;
        label_count=label_count+1;
    
    end 
   
   end
end


