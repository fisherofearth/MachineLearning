function [ y_hat ] = ClassifyAdaBoost( data, h, alpha, D )
%CLASSIFYADABOOST Summary of this function goes here
%   Detailed explanation goes here
    N = size(data,1);
    L = size(alpha,1);
    y_hat = zeros(N,L);

    for n = 1 : N
        for l = 1 : L
            x = data(n,h(1,l)+1);
            y = data(n,1);          
            y_hat(n,l) = h(x+2,l);
            if(y_hat(n,l) == 0)
                y_hat(n,l) = -1;
            end
        end
    end
    
    y_hat = y_hat * alpha;
    
    
%     for n = 1 : N
%         y_hat(n,1) 
%         
%     end
%      
    
    
    
    
    y_hat=(sign(y_hat) +1) /2;


end

