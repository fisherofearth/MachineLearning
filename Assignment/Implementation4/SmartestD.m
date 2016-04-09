function [ d ] = SmartestD(eigenvalues, retain )
%SMARTESTD Summary of this function goes here
%   Detailed explanation goes here


    d = 1;
    sumEV = sum(eigenvalues);
    while((sum(eigenvalues(1:d,1))/sumEV)<retain)
        d = d + 1;
    end


end

