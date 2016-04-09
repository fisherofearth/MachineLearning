function [ h, alpha, epsilon, distn] = AdaBoost( trainingData,L )
%ADABOOST Summary of this function goes here
%   Detailed explanation goes here

    S = trainingData;

    % Initialize D uniformally
    D = ones(size(S,1),1);
    D = D/ norm(D,1);% Normalization

    h = zeros(3,L);
    alpha = zeros(L,1);
    epsilon = zeros(L,1);
    
    for l = 1 : L;
        distn(:,l) = D;
%         [ h(:,l), ~, ~, ~ ] = LearnD( S, D);   
%         [ e ] = AdaBoostError( h(:,l), S, D );
        [ h(:,l), e ] = Learnhj( S, D );
        epsilon(l,1) = e;
        alpha(l,1) = 0.5 * (log((1-e)/e));
        
        
        for i = 1 : size(S,1)
            yi = S(i,1);
            xi = S(i,h(1,l)+1);
            yi_hat = h(xi+2, l) ;
            if(yi_hat == yi)
                scale = -1;
            else
                scale = 1;
            end
            D(i,1) = D(i,1) * exp(alpha(l,1) * scale);
        end
        
        D = D / norm(D,1);   % Normalization
       
    end
end

