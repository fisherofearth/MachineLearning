function [ classes, centers  ] = KMeans10( data, K , times )
%KMEANS10 Summary of this function goes here
%   Detailed explanation goes here

    D = size(data,2); % demention
    N = size(data,1);
    
    classes = zeros(N,10);
    centers= zeros(2,D,10);
    for i = 1: 10
        [ classes(:,i), centers(:,:,i) ]  = KMeans(data, K , times );
    end
    




end

