function [ classfier ] = FindClassifer_BGA( filename_clss0,  filename_clss1, classifier, eta, converge)
%use Batch Gradient Ascent algorithm to learn a binary classifier
% output:
%   classfier - 
% input :
%   filename_clssA - a list of filenames, the filename w/t extention, e.g [10001 10002 ... 10100]
%   filename_clssB - a list of filenames, the filename w/t extention


    %test code
%     filename_clss0 = [30001 : 30050];
%     filename_clss1 = [20001:20050 30001:30050]
%     eta = 1;
%     converge = 100;

    %input parameters 
    class0 = filename_clss0;
    class1 = filename_clss1;
    data   = [class0 class1];

    % compute the sizes
    sizeClassifier = size(ReadImage(data(1))) * [1; 0] +1;  % How many elements in classifier
    sizeData = size(data) * [0; 1]; % How many pic used in this training algorithm

    %initial variables
    if classifier == 0
         W = zeros(1,sizeClassifier); 
    else
         W = classifier;
    end

    for con = 1 : converge
        d = zeros(1,sizeClassifier); 
        for i = 1 : sizeData
            X = [1;  ReadImage(data(i))];
            yHat = 1 / (1 + exp(-W * X));
            if i < size(class0) * [0; 1]
                yReal = 0; 
            else
                yReal = 1; 
            end
            error = yReal - yHat;
            d = d + error * (X');
        end
        W = W + (eta * d);

    end
    classfier = W;
end

