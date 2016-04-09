function [ accuracy ] = AccuracyD( data, classifier, D )
%ACCURACY Summary of this function goes here
%   Detailed explanation goes here

    x = data(:,classifier(1,1)+1);
    y = data(:,1);
    
    N = size(data,1);
    
    y_hat = zeros(N,1);
    for n = 1 : N
        y_hat(n,1) = classifier(x(n,1)+2);
    end
    a = find( (y - y_hat) == 0);
    
    accuracy = length(a)/N;
end 

