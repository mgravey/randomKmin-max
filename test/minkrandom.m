function [values,index] = minkrandom(array,k)
%MINKRANDOM Summary of this function goes here
%   Detailed explanation goes here
randomIndex=randperm(length(array));
[values,index]=mink(array(randomIndex),k);
index=randomIndex(index);
end

