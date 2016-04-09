function [ distance ] = DistToCenter( point, center)
%DISTTOCENTER Summary of this function goes here
%   Detailed explanation goes here

distance = norm((point - center),2);

end

