function [ newData ] = Shrink2( trainData, freq, Th_H, Th_L)
%SHRINK2 Summary of this function goes here
%   Detailed explanation goes here
    newData = trainData;
    for i = 1 : size(newData,1)
        f = freq(newData(i,2),1);
        if (f > Th_H || f < Th_L )
            newData(i,3) = 0;
        end
    end
        
end

