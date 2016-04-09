function [ H ] = InformationGain( root, n1, n2  )
%INFORMATIONGAIN Summary of this function goes here
%   Detailed explanation goes here
p1 = n1(1)/sum(n1);
p2 = n1(2)/sum(n1);
if(p1 ==0 || p2==0)
    H1 = 0;
else
    H1 = -(p1*log2(p1) + p2*log2(p2));
end

p1 = n2(1)/sum(n2);
p2 = n2(2)/sum(n2);
if(p1 ==0 || p2==0)
    H2 = 0;
else
    H2 = -(p1*log2(p1) + p2*log2(p2));
end

p1 = root(1)/sum(root);
p2 = root(2)/sum(root);
if(p1 ==0 || p2==0)
    Hs = 0;
else
    Hs = -(p1*log2(p1) + p2*log2(p2));
end


Pr1 = sum(n1) / sum(root);
Pr2 = sum(n2) / sum(root);

H = Hs - (Pr1 * H1) - (Pr2 * H2);
    
    

end

