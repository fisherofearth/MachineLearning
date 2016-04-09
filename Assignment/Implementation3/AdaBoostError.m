function [ epsilon ] = AdaBoostError( h, S, D )
%ADABOOSTERROR Summary of this function goes here
%   Detailed explanation goes here

    x = S(:,h(1,1)+1);
    y = S(:,1);
    N = size(S,1);
    y_hat = zeros(N,1);
    for n = 1 : N
        y_hat(n,1) = h(x(n,1)+2,1);
    end
    diff = find( (y - y_hat) ~= 0);
%     same = find( (y - y_hat) == 0);
    
    epsilon = sum(D(diff,1));
%     epsilon_s = sum(D(same,1));
        
end

