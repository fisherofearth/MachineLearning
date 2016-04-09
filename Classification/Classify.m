function [ accuracy, result] = Classify(classifiers, filename_clss0, filename_clss1, filename_clss2)
% Input:
%   Classifiers       - [C1; C2; C3 ...]
%   filename_clsses   - [filename_clsse0; filename_clsse1; filename_clsse2 ...]
% Output:
%     accuracy - 1 - (sum of errors / sample saize)
%     records - 
% 
    
% input parameters
    class0 = filename_clss0;
    class1 = filename_clss1;
    class2 = filename_clss2;
    classes = [class0 class1 class2]
    W = classifiers;
    
    % compute the sizes
    sizeClassifier = size(W) * [0; 1];  % How many elements in classifier
    sizeClass0 = size(class0) * [0; 1]; 
    sizeClass1 = size(class1) * [0; 1]; 
    sizeClass2 = size(class2) * [0; 1]; 
    sizeClasses = sizeClass0 + sizeClass1 + sizeClass2;
    
    % initialize [yHat] for the three classes
    yHat_class0 = ones(1, sizeClass0);
    yHat_class1 = ones(1, sizeClass1);
    yHat_class2 = ones(1, sizeClass2);
    yReal_classes = [yHat_class0*0 yHat_class1*1 yHat_class2*2];
    yHat_classes = [];
   
    threshold = 0; % if < threshold -> class 0, otherwise -> class 1  
    
    % apply Classifier 1
    yHat_A = [];
    for i = 1 : sizeClasses
        X = [1;  ReadImage(classes(i))];
        if W(1, :) * X < threshold % if true
            yHat_A(1, i) = 0;
        else
            yHat_A(1, i) = 1;
        end
    end

    % apply Classifier 2
    yHat_B = [];
    for i = 1 : sizeClasses
        X = [1;  ReadImage(classes(i))];
        if W(2, :) * X < threshold % if true
            yHat_B(1, i) = 0;
        else
            yHat_B(1, i) = 1;
        end
    end

    sumAcc = 0;
    
    for i = 1 : size(yReal_classes) * [0; 1]
        if yHat_A(1, i) == 0 % class 1
            if yHat_B(1, i) == 0 % class 1-2
                yHat_classes(1, i) = 0; % This is class 1!
            else %class 3
                yHat_classes(1, i) = -1;  % This is a mistake!
            end
        else % class 2-3
            if yHat_B(1, i) == 0 % class 1-2
                yHat_classes(1, i) = 1;% This is class 2!
            else% class 3
                yHat_classes(1, i) = 2;% This is class 3!
            end
        end
        
        if yHat_classes(1, i) == yReal_classes(1, i) %if match
            sumAcc = sumAcc+1;
        end
        
    end
    
    accuracy = sumAcc / sizeClasses;
    
    result = yHat_classes;
end

