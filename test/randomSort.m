function [values,index] = randomSort(array,k)
%RANDOMSORT Summary of this function goes here
%   Detailed explanation goes here
mins=inf(k,2);

cpt=0;

for i=1:numel(array)
    if(array(i)<=mins(end,1))
        xes=find(mins(:,1)==mins(end,1));
        x=xes(randi(length(xes)));
        if(array(i)==mins(end,1))
            cpt=cpt+1;
            if((length(xes)+cpt)*rand()<length(xes))
                mins(x,:)=[array(i),i];
            end
        end
        if(array(i)<mins(end,1))
            if(length(xes)==1)
                cpt=0;
            else
               cpt=cpt+1; 
            end
            mins(x,:)=[array(i),i];
            [~,ordering]=sort(mins(:,1));
            mins=mins(ordering,:);
        end
    end
end
values=mins(:,1);
index=mins(:,2);
end

