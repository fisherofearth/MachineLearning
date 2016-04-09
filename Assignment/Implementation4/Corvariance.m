function [ corvariance ] = Corvariance( data )
%CORVARIANCE Summary of this function goes here
%   Detailed explanation goes here
    m = (mean(data))';
    N = size(data,1);
    D = size(data,2);
    corvariance = zeros(D,D);
    for i = 1 : N
        
        corvariance = corvariance + ((data(i,:)'-m) * ((data(i,:)'-m)'));
    end
    corvariance = corvariance / N;
end

