function [ cneters ] = InitializeCenter( num, D, minV, maxV );
%INITIALIZECENTER Summary of this function goes here
%   Detailed explanation goes here

cneters = randi(maxV+1,D,num)-1 + minV;

end

