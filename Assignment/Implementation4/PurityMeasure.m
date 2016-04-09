function [ accuracy, classes ] = PurityMeasure( classes, trueLabels )
%PURITYMEASURE Summary of this function goes here
%   Detailed explanation goes here
N = size(trueLabels,1);

% s7 = size(find(trueLabels(:,1) == 7),1);
% s9 = size(find(trueLabels(:,1) == 9),1);
% 
% if(s7<s9)
%     label = [7 9];
% else
%     label = [9 7];
% end
    

% c1 = size(find(classes(:,1) == 1),1);
% c2 = size(find(classes(:,1) == 2),1);

%     
% 
% testLabel = (trueLabels-5)/2;
% d = testLabel - classes;
% acc1 = size(find(d ==0 ),1)/N;
% 
% testLabel = -(trueLabels-11)/2;
% d = testLabel - classes;
% acc2= size(find(d ==0 ),1)/N;
% 
% 
% accuracy = max(acc1, acc2);

trueLabels = (trueLabels-5)/2;
combLabel = [classes,trueLabels ];

c1 = combLabel(find(combLabel(:,1) == 1),:);
% c2 = combLabel(find(combLabel(:,1) == 2),:);
n = [];
n(1) = size(find( c1(:,2) == 1),1);
n(2)= size(find( c1(:,2) == 2),1);

[~,idxMax] = max(n);
[~,idxMin] = min(n);

classes(find(combLabel(:,1) == 1),:) = classes(find(combLabel(:,1) == 1),:)*0+idxMax;
classes(find(combLabel(:,1) == 2),:) = classes(find(combLabel(:,1) == 2),:)*0+idxMin;

d = trueLabels - classes;
accuracy = size(find(d ==0 ),1)/N;

end

