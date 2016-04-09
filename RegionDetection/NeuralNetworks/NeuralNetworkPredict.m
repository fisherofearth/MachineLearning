function [  Y_hat] = NeuralNetworkPredict( testData, PCs, W_ij, W_jk )

    dim = size(W_ij,1) - 1;
%     [ PCs ] = PCA( testData, dim );
    data_DR = (PCs' * testData')';

    X = [ones(size(data_DR,1),1),data_DR];
    
    N = size(X,1);
    Y_hat = zeros(N,1);
    for i = 1 : N
        [ Y_hat(i,1), ~ ] = NNComputeY(X(i,:)', W_ij, W_jk );
    end


end

