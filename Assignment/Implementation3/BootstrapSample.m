function [ bootstrapSampleData ] = BootstrapSample( sampleDat, N )
%BOOTSTRAPSAMPLE Summary of this function goes here
%   Detailed explanation goes here

    uniformDist = ones(size(sampleDat,1),1);
    uniformDist = uniformDist/ norm(uniformDist,1);% Normalization
    
    bootstrapSampleData = zeros(N,size(sampleDat,2));
    for n = 1: N
        bootstrapSampleData(n,:) = sampleDat(find(rand<cumsum(uniformDist),1,'first'),:); 
    end
    
end

