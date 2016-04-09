function [ pd, prior] = BayesTrain( data0, data1, dim, dist )

    trainData = vertcat(data0, data1);

    % reduce dimension
    [ PCs ] = PCA( trainData, dim );
    data_DR = (PCs' * trainData')';

    % Normalization
%     data_DR = data_DR - (min(min(data_DR)));
%     data_DR = data_DR/(max(max(data_DR)));

    % Reorganize data
    data0 = data_DR(1:size(data0,1), :);
    data1 = data_DR(size(data0,1)+1:end, :);

    n0 = size(data0,1);
    n1 = size(data1,1);
    D = size(data1,2);

%     Py0 = (n0 + 1)/(n0 + n1 +2);
    Py1  = (n1 + 1)/(n0 + n1 +2);

    %% compute pdf
    for i = 1 : D
        pd(i,1) = fitdist(data0(:,i),dist);
        pd(i,2) = fitdist(data1(:,i),dist);
    end

    prior = Py1;

end


