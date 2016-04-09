function [ Y_hat ] = LogisticRegressionPredict( data, PCs, W )

    dim = size(W,1) -1;
    
    data_DR = (PCs' * data')';

    N = size(data_DR,1);

    X = [ones(size(data_DR,1),1),data_DR];
    Y_hat = -( (X*0.1) * W);
    for i = 1 : N
        Y_hat(i,1) = 1/(1 +exp(Y_hat(i,1)));
    end

end

