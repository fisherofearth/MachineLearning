function [ classes, centers ] = KMeans( data, K , times)
%KMEANS Summary of this function goes here
%   Detailed explanation goes here
    data = data';
    D = size(data,1); % demention
    centers = InitializeCenter( K, D, 0, 255 );
    N = size(data,2);
    classes = zeros(1,N);

    for l = 1 : times
        for i = 1 : N
            [ distances ] = DistToCenters( data(:,i), centers );
            [~,classes(1,i)] = min(distances);
        end

        for k = 1: K
            centers(:,k) = GetCenter(data(:,find(classes(1,:) == k)));
        end

    end

    classes=classes';
    centers = centers';
end

