function [ data ] = NormalizeMatrix( data )
%NORMALIZE Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : size(data,1)
    data(i,2:size(data,2)) = Normalize(data(i,2:size(data,2)));
end

% 
% tmp  = data(:,2:size(data,2));
% data(:,2:size(data,2)) = tmp/max(max(abs(tmp)));
% data(:,2:size(data,2)) = data(:,2:size(data,2))/sum(sum(data(:,2:size(data,2))));

% data(:,2:size(data,2)) = normr( data(:,2:size(data,2)));

% data(:,2:size(data,2)) = normc( data(:,2:size(data,2)));
end
