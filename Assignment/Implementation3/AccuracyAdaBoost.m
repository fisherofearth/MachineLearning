function [ accuracy ] = AccuracyAdaBoost( data, h, alpha,D )
%ACCURACYADABOOST Summary of this function goes here
%   Detailed explanation goes here
    
    y_hat = ClassifyAdaBoost( data, h, alpha );
    
    a = find( (data(:,1) - y_hat) == 0);
    accuracy = size(a,1)/size(data,1);

end