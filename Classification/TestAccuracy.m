function [ accuracy, record,record2] = TestAccuracy( classifier, filename_clss0, filename_clss1)

    %test code
%     filename_clss0 = [60001 : 60050];
%     filename_clss1 = [70001:70050 80001:80030]
%     classifier = C1;

% input parameters
    class0 = filename_clss0;
    class1 = filename_clss1;
    W = classifier;

    % compute the sizes
    sizeClassifier = size(ReadImage(class0(1))) * [1; 0] +1;  % How many elements in classifier
    sizeClass0 = size(class0) * [0; 1]; 
    sizeClass1 = size(class1) * [0; 1]; 
    
    sumAcc = 0;

    X = [];    
    thr = 0;
    for i = 1 : sizeClass0
        X = [1;  ReadImage(class0(i))];

        wx = W * X
        yHat = 1/(1+exp(-wx));
        myRecord(i,1) = wx;
        myRecord2(i,1) = yHat;
        if wx < thr
            sumAcc = sumAcc + 1;

        end
    end

    for i = 1 : sizeClass1
        X = [1;  ReadImage(class1(i))];

        wx = W * X
        yHat = 1/(1+exp(-wx));
        
        myRecord(i+sizeClass0,1) = wx;
        myRecord2(i+sizeClass0,1) = yHat;
        if wx >= thr
            sumAcc = sumAcc + 1;
        end
    end

%     accuracy = sumAcc / (sizeClass0 + sizeClass1);
  accuracy = 1- (size(find(myRecord2(1:sizeClass0,1)==1)) * [1;0] + size(find(myRecord2(sizeClass0:sizeClass0+sizeClass1,1)==0)) * [1;0]) / (sizeClass0 + sizeClass1)

    
    record = myRecord;
    record2= myRecord2;
end

