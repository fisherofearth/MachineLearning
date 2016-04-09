function [ accuracy, errorRate ] = AccuracyBagging( S, h )
%ACCURACYBAGGING Summary of this function goes here
%   Detailed explanation goes here

    N = size(S,1);
    T = size(h,2); % num of hypophysis
    
    y = zeros(N,1);
    y_hat = zeros(N,T);
    for n = 1 : N % for every sample
        y(n,1) = S(n,1);
        for t = 1 : T
            y_hat(n,t) = h(S(n,h(1,t)+1)+2,t);
        end
    end
    
    sig = sign(sum(y_hat,2) + (rand-0.5) - (T/2));
    y_hat = (sig+1)/2;
    
    tmp = find( (y - y_hat) == 0);
    accuracy = length(tmp)/N;
    errorRate = 1 - accuracy;

end

