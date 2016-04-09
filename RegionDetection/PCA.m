function [ PCs ] = PCA( data, num )
%PCA Summary of this function goes here
%   Detailed explanation goes here

    % retain = 0.8;
    S = cov(data);
    [eigenvectors, ~] = eig(S);
    eigenvalues= eig(S);
    % Rank by eigen value (direction = descend)
    [eigenvalues,I] = sort(eigenvalues,'descend');
    eigenvectors = eigenvectors(:,I);
    clear I
    % [ smartestD ] = SmartestD(eigenvalues, retain);
    PCs = eigenvectors(:,1:num);

end

