function [ weightedVector ] = WeightData( vector, distribution )
%WEIGHTDATA Summary of this function goes here
%   Detailed explanation goes here

% for row = 1 : size(data,1)
%     for col = 1 :size(data,2)
%         data(row,col) = data(row,col) * Distribution(row,1);
%     end
% end
%     
    weightedVector = zeros(size(vector,1),1);
    for n = 1: size(vector,1)
        weightedVector(n,1) = vector(n,1) * distribution(n,1);
    end
    
    
end

