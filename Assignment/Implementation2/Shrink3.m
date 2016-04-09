function [ newData ] = Shrink3( data, shinkedDictIdx )
%SHRINK3 Summary of this function goes here
%   Detailed explanation goes here
newData = zeros(size(data,1),3);

c = 1;
for i = 1 : size(data,1)
    tmp = shinkedDictIdx(data(i,2),1);
    if(tmp>0)
        newData(c,1) = data(i,1);
        newData(c,3) = data(i,3);
        newData(c,2) = tmp;
        c = c + 1;
    end
end

newData(c:end,:) = [];
end

