% Define the type of shoes
trainBT   = [10001 : 10120];
trainFL   = [20001 : 20120];
trainRS   = [30001 : 30120];

testBT   = [60001 : 60050];
testFL   = [70001 : 70050];
testRS   = [80001 : 80050];

eta = [1E-3 1E-2 1E-1 1 1E+1 1E+2 1E+3];
eta = 1;
cycle =2000;


%% Find classifier 1
% classify -> boots+flipflop OR runningShoes
C1 = [];
for i = 1 : size(eta)*[0; 1]
    C1(i,:) = FindClassifer_BGA(trainBT, [trainFL trainRS], 0, eta(1,i), cycle);
%    C1(i,:) = FindClassifer_BGA([trainBT, [trainFL trainRS], C1(i,:),eta(1,i), cycle);
end
%% Find classifier 2
% classify -> boots OR flipflop+runningShoes
C2 = [];
for i = 1 : size(eta)*[0; 1]
    C2(i,:) = FindClassifer_BGA([trainBT trainFL], trainRS, 0, eta(1,i), cycle);
end
    
%% Test accuracy
group = 1;
record = zeros(size([trainBT trainFL trainRS])*[0; 1],4);

[accuracy(1,1), record1, record2] = TestAccuracy(C1(group,:), trainBT, [trainFL trainRS]);
figure
stem(record1)
title('Accuracy of classification (training data,classifier A, eeta = 1)');
xlabel('sample');
ylabel('w*x')
figure
plot(record2)
title('Accuracy of classification (training data,classifier A, eta = 1)');
xlabel('sample');
ylabel('1/(1+exp(-w*x)')


[accuracy(1,1), record1, record2] = TestAccuracy(C1(group,:), testBT, [testFL testRS]);
resultTestC1 = record2;
figure
stem(record1)
title('Accuracy of classification (test data,classifier A, eeta = 1)');
xlabel('sample');
ylabel('w*x')
figure
plot(record2)
title('Accuracy of classification (test data,classifier A, eta = 1)');
xlabel('sample');
ylabel('1/(1+exp(-w*x)')


[accuracy(1,1), record1, record2] = TestAccuracy(C2(group,:), [trainBT trainFL], trainRS);
figure
stem(record1)
title('Accuracy of classification (training data,classifier B, eta = 1)');
xlabel('sample');
ylabel('w*x')
figure
plot(record2)
title('Accuracy of classification (training data,classifier B, eta = 1)');
xlabel('sample');
ylabel('1/(1+exp(-w*x)')
accuracy

[accuracy(1,1), record1, record2] = TestAccuracy(C2(group,:), [testBT testFL], testRS);
resultTestC2 = record2;
figure
stem(record1)
title('Accuracy of classification (test data,classifier B, eta = 1)');
xlabel('sample');
ylabel('w*x')
figure
plot(record2)
title('Accuracy of classification (test data,classifier B, eta = 1)');
xlabel('sample');
ylabel('1/(1+exp(-w*x)')
accuracy

  


%% Apply multi-class classfier on test data
group = 1;
classifiers = [C1(group,:); C2(group,:)];
[accuracy, result] = Classify(classifiers, testBT, testFL, testRS);


plot(result);
title('Result of classification (test data,classifier A and B, eta = 1)');
xlabel('sample');
ylabel('class')

figure
stem(result);
title('Result of classification (test data,classifier A and B, eta = 1)');
xlabel('sample');
ylabel('class')










