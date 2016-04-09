function [  Y_hat, A  ] = NNComputeY(  x, W_ij, W_jk  )

    A = Sigmoid(W_ij' * x);
    A(1,1) = 1;
    Y_hat = Sigmoid(W_jk' * A);


end

