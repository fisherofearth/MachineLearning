function [ y_hat ] = BayesPredict( testData, pd, prior )
% x - vector
    
    N = size(testData,1);
    y_hat = zeros(N,1);
    for j = 1 : N
        x = testData(j,:)';
        D = size(x,1);
        P = zeros(D,2);
        for i = 1 : D
            P(i,1) = cdf(pd(i,1), x(i,1));
            P(i,2) = cdf(pd(i,2), x(i,1));
        end

        Px = log(((1 - prior) * prod(P(:,1),1)) ...
            + (prior * prod(P(:,2),1)));

        y_hat(j,1) = (log(prior) + sum(log(P(:,2)))) -  (Px);
    end
    
    
    
end

