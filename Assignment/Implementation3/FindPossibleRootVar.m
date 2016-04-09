function [ PRV ] = FindPossibleRootVar( varIdx, LVL, lvl)
%FINDPOSSIBLEROOTVAR Summary of this function goes here
%   Detailed explanation goes here

LVL = 5;
lvl = 4;


PRV = zeros(LVL-lvl+1, 2^(lvl-1));


for v = 1 : size(PRV,2)
    
    flag = zeros(LVL,1);

    for uf = 1 : lvl - 1;
        varIdx(uf,)
    end

   
end


end

