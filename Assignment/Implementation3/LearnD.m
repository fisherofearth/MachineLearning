function [ classifier, maxInfo, InfoG, classCount ] = LearnD( data, distribution)
%LEARN Summary of this function goes here
%   Detailed explanation goes here

    classifier = zeros(1,3);

    x = data(:,2:23);
    y = data(:,1);

%     N = size(x,1);
    I = size(x,2);

    
    D = distribution;
    ygx0 = WeightData( -(y-1), D );
    ygx1 = WeightData( y, D );
    
    rt = [sum(ygx0) sum(ygx1) ];
    InfoG = zeros(I,1);
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

        InfoG(i,1)= InformationGain( rt, n1, n2 );
    end

    [maxInfo, classifier(1,1)] = max(InfoG);
    
    [~, idx] = max(classCount(classifier(1,1),3:4));
    classifier(1,2) = idx-1;
    
    [~, idx] = max(classCount(classifier(1,1),5:6));
    classifier(1,3) = idx-1;
        
%     X = [2,2,3,3];
%     L = [0,1,0,1];
%     [value, idx] = max(classCount(classifier(1,1),3:6));
%     X1 = X(idx);
%     classifier(1,X1) = L(idx);
%     
%     if(X1 == 2)
%         X2 = 3;
%     else
%         X2 = 2;
%     end
%     classifier(1,X2) = (L(idx) -1)^2;
    
    
    classifier = classifier';
end

