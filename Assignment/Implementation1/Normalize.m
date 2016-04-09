function [ output ] = Normalize( vector )
%NORMALIZE Summary of this function goes here
%   Detailed explanation goes here


% output = vector-min(vector);
% output = output/sum(output);

output = vector/max(abs(vector));

end

