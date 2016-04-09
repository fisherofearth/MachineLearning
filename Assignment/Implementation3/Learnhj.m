function [ h, e ] = Learnhj( S, distribution )
%LEARNHJ Summary of this function goes here
%   Detailed explanation goes here
    
    hj = zeros(3,size(S,2)-1);
    
    x = S(:,2:size(S,2));
    y = S(:,1);

%     N = size(x,1);
    I = size(x,2);

    
    D = distribution;
    ygx0 = WeightData( -(y-1), D );
    ygx1 = WeightData( y, D );
    
    rt = [sum(ygx0) sum(ygx1) ];
   
    classCount = zeros(I,6);
    for i = 1 : I
        classCount(i,1:2) = rt;

        ygx = y(x(:,i) == 0, 1);
        D = distribution(x(:,i) == 0, 1);
        ygx0 = WeightData( -(ygx-1), D );
        ygx1 = WeightData( ygx, D );
        n1 = [sum(ygx0) sum(ygx1)];
        classCount(i,3:4)= n1;

        ygx = y(x(:,i) == 1,1);
        D = distribution(x(:,i) == 1, 1);
        ygx0 = WeightData( -(ygx-1), D );
        ygx1 = WeightData( ygx, D );
        
        n2 = [sum(ygx0) sum(ygx1)];
        classCount(i,5:6) = n2;
    end

    ep = zeros(size(S,2)-1,1);
    for i = 1 : size(S,2)-1
        hj(1,i) = i;
    
        [~, idx] = max(classCount(i,3:4));
        hj(2,i) = idx-1;

        [~, idx] = max(classCount(i,5:6));
        hj(3,i) = idx-1;
        
        [ ep(i,1) ] = AdaBoostError( hj(:,i), S, distribution );
    end
    
    [~, idx] = min(ep);
    
    h =  hj(:,idx) ;
    e =  ep(idx,1) ;
    
end

