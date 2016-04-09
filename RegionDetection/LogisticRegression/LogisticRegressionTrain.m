function [ W, Y_hat ] = LogisticRegressionTrain( data0, data1, PCs, times, LR )

trainData = vertcat(data0,data1);

dim = size(PCs,2);
data_DR = (PCs' * trainData')';

X = [ones(size(data_DR,1),1),data_DR];
Y = [ones(size(data0,1),1)*0; ones(size(data1,1),1)*1];

% initialization
dim = size(X,2) -1;
W = ones(dim+1,1);
N = size(Y,1);
Y_hat = zeros(N,1);
DSSE = zeros(dim+1,1);

for L = 1 : times
    Y_hat = -( X * W);
    for i= 1 :N
        Y_hat(i,1) = 1/(1 +exp(Y_hat(i,1)));
    end   
    diff = (Y - Y_hat);  
    DSSE = (X' * diff);   
    W = W + (LR * DSSE);
end


end

