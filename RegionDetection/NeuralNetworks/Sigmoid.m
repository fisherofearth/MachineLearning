function [ y ] = Sigmoid( x )
%SIGMOID Summary of this function goes here
%   Detailed explanation goes here

    N = size(x,1);
    y = zeros(N,1);
    
    for i = 1: N
        y(i,1) = (1 / (1 + exp(-x(i,1))));
    end
end

