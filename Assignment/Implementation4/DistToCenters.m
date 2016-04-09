function [ distances ] = DistToCenters( point, centers )
%DISTTOCENTERS Summary of this function goes here
%   Detailed explanation goes here

distances = zeros(size(centers,2), 1);
for c = 1 : size(centers,2)
    distances(c,1) = norm((point - centers(:,c)),2);
end

end

