function [ W_ij, W_jk ] = NeuralNetworkTrain( data0, data1, dim, learnRate, times )

    trainData = vertcat(data0,data1);

    [ PCs ] = PCA( trainData, dim );
    data_DR = (PCs' * trainData')';

    X = [ones(size(data_DR,1),1),data_DR/max(max(data_DR))];
    Y = [ones(size(data0,1),1)*0; ones(size(data1,1),1)*1];

    N = size(Y,1);

    I = dim+1;
    J = 10+1;
    K = 1;

    W_ij = random('unif',0.01,1,I,J);
    W_jk = random('unif',0.01,1,J,K);

    delta_k = zeros(K,1);
    delta_j = zeros(J,1);

    for L = 1: times
        roder = randperm(N);
        X = X(roder, :);
        Y = Y(roder, :);

        for i = 1 : N
            x = X(i,:)';
            y = Y(i,:)';

            [ y_hat, A ] = NNComputeY(x, W_ij, W_jk );


            delta_k = ((y_hat - y) *y_hat') * (1-y_hat);

            for j = 1 : J
                delta_j(j,1) = (W_jk(j,:) * delta_k) * (A(j,1)* (1-A(j,1)));
            end

            for k = 1: K
                W_jk(:,k) = W_jk(:,k) - (learnRate * (delta_k(k,1) * A));
            end

            for j = 1: J
                W_ij(:,j) =  W_ij(:,j)  -  (learnRate * (delta_j(j,1) * x));   
            end
        end
    end

end

