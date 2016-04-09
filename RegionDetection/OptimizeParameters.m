%% LarningRate_LR
clear all; close all;
load 'gist.mat'
testData_pos = trainData_pos(301:500,:);
testData_neg = trainData_neg(301:500,:);

trainData_pos = trainData_pos(1:300,:);
trainData_neg = trainData_neg(1:300,:);


LR = [0.5 : -0.001: 0.001];
acc = [];
for n = 1 : size(LR,2)
    dim = 100;
    times = 100;
    
    [ PCs ] = PCA( vertcat(trainData_neg, trainData_pos), dim );
    [ W, ~ ] = LogisticRegressionTrain( ...
        trainData_neg, trainData_pos, PCs, times, LR(n));

    testData = vertcat(testData_neg,testData_pos);
    [ Y_hat ] = LogisticRegressionPredict( testData, PCs, W );
    
    N = size(testData,1);
    test = [];
    for i = 1 : N
        if(Y_hat(i,1)>0.5)
            test(i,1) = 1;
        else
            test(i,1) = 0;
        end
    end
    Y = [ones(size(testData_neg,1),1)*0; ones(size(testData_pos,1),1)*1];
    acc(n) = size(find((Y-test)==0),1)/N;
end

plot(LR,smooth(acc,20),'LineWidth',2);
ylabel('Accuracy');
xlabel('Learning rate');
title('Learning Rate Selection - Logistic Regression');

%% LearningRate_NN
clear all; close all;
load 'gist.mat'
testData_pos = trainData_pos(301:500,:);
testData_neg = trainData_neg(301:500,:);

trainData_pos = trainData_pos(1:300,:);
trainData_neg = trainData_neg(1:300,:);

dim = 15;
learnRate = [0.6 : -0.01: 0.1];
times = 300;

acc = [];
for n = 1 : size(learnRate,2)

    [ PCs ] = PCA( vertcat(trainData_neg, trainData_pos), dim );
    [ W_ij, W_jk ] = NeuralNetworkTrain(  trainData_neg, trainData_pos, dim, learnRate(n), times );

    testData = vertcat(testData_neg,testData_pos);
    Y_hat = NeuralNetworkPredict( testData,PCs, W_ij, W_jk );
    % plot(Y_hat);
    N = size(testData,1);
    test = [];
    for i = 1 : N
        if(Y_hat(i,1)>0.6)
            test(i,1) = 1;
        else
            test(i,1) = 0;
        end
    end
    Y = [ones(size(testData_neg,1),1)*0; ones(size(testData_pos,1),1)*1];
    acc(n) = size(find((Y-test)==0),1)/N;
end
acc2 = smooth(acc,15)
plot(learnRate(5:end-1),acc2(5:end-1),'LineWidth',2);
ylabel('Accuracy');
xlabel('Learning rate');
title('Learning Rate Selection - Neural Network');



%% Training Time_LR
clear all; close all;
load 'gist.mat'
testData_pos = trainData_pos(301:500,:);
testData_neg = trainData_neg(301:500,:);

trainData_pos = trainData_pos(1:300,:);
trainData_neg = trainData_neg(1:300,:);

LR = 0.2;
times = [100:100:3000];
acc = [];
for n = 1 : size(times,2)
    dim = 100;
    
    [ PCs ] = PCA( vertcat(trainData_neg, trainData_pos), dim );
    [ W, ~ ] = LogisticRegressionTrain( ...
        trainData_neg, trainData_pos, PCs, times(n), LR);

    testData = vertcat(testData_neg,testData_pos);
    [ Y_hat ] = LogisticRegressionPredict( testData, PCs, W );

    
    N = size(testData,1);
    test = [];
    for i = 1 : N
        if(Y_hat(i,1)>0.5)
            test(i,1) = 1;
        else
            test(i,1) = 0;
        end
    end
    Y = [ones(size(testData_neg,1),1)*0; ones(size(testData_pos,1),1)*1];
    acc(n) = size(find((Y-test)==0),1)/N;
end

acc2 = smooth(acc,10);
plot(times(1,1:20),acc2(1:20,1),'LineWidth',2);
ylabel('Accuracy');
xlabel('Training time');
title('Training Time Selection - Logistic Regression');

%% Training Time_NN
clear all; close all;
load 'gist.mat'
testData_pos = trainData_pos(301:500,:);
testData_neg = trainData_neg(301:500,:);

trainData_pos = trainData_pos(1:300,:);
trainData_neg = trainData_neg(1:300,:);

dim = 15;
learnRate = 0.4;
% times = 300;
times = [10:10:100, 150:50:600 ];
acc = [];
for n = 1 : size(times,2)

    [ PCs ] = PCA( vertcat(trainData_neg, trainData_pos), dim );
    [ W_ij, W_jk ] = NeuralNetworkTrain(  trainData_neg, trainData_pos, dim, learnRate, times(n) );

    testData = vertcat(testData_neg,testData_pos);
    Y_hat = NeuralNetworkPredict( testData,PCs, W_ij, W_jk );
    % plot(Y_hat);
    N = size(testData,1);
    test = [];
    for i = 1 : N
        if(Y_hat(i,1)>0.6)
            test(i,1) = 1;
        else
            test(i,1) = 0;
        end
    end
    Y = [ones(size(testData_neg,1),1)*0; ones(size(testData_pos,1),1)*1];
    acc(n) = size(find((Y-test)==0),1)/N;
end

plot(times,smooth(acc,3),'LineWidth',2);
ylabel('Accuracy');
xlabel('Training time');
title('Training Time Selection - Neural Network');

%% Dimension _LR
clear all; close all;
load 'gist.mat'
testData_pos = trainData_pos(301:500,:);
testData_neg = trainData_neg(301:500,:);

trainData_pos = trainData_pos(1:300,:);
trainData_neg = trainData_neg(1:300,:);

LR = 0.05;
times = 1000;
dim = [10:10:500];
acc = [];
for n = 1 : size(dim,2)
    
    
    [ PCs ] = PCA( vertcat(trainData_neg, trainData_pos), dim(n) );
    [ W, ~ ] = LogisticRegressionTrain( ...
        trainData_neg, trainData_pos, PCs, times, LR);

    testData = vertcat(testData_neg,testData_pos);
    [ Y_hat ] = LogisticRegressionPredict( testData, PCs, W );

    
    N = size(testData,1);
    test = [];
    for i = 1 : N
        if(Y_hat(i,1)>0.5)
            test(i,1) = 1;
        else
            test(i,1) = 0;
        end
    end
    Y = [ones(size(testData_neg,1),1)*0; ones(size(testData_pos,1),1)*1];
    acc(n) = size(find((Y-test)==0),1)/N;
end

plot(dim,smooth(acc,10),'LineWidth',2);
ylabel('Accuracy');
xlabel('Dimension');
title('Reduced Dimension Selection - Logistic Regression');


%% Dimension _NN
clear all; close all;
load 'gist.mat'
testData_pos = trainData_pos(301:500,:);
testData_neg = trainData_neg(301:500,:);

trainData_pos = trainData_pos(1:300,:);
trainData_neg = trainData_neg(1:300,:);

dim = [5:5:150];
learnRate = 0.3;
times = 150;
acc = [];
for n = 1 : size(dim,2)

    [ PCs ] = PCA( vertcat(trainData_neg, trainData_pos), dim(n) );
    [ W_ij, W_jk ] = NeuralNetworkTrain(  trainData_neg, trainData_pos, dim(n), learnRate, times);

    testData = vertcat(testData_neg,testData_pos);
    Y_hat = NeuralNetworkPredict( testData,PCs, W_ij, W_jk );
    % plot(Y_hat);
    N = size(testData,1);
    test = [];
    for i = 1 : N
        if(Y_hat(i,1)>0.6)
            test(i,1) = 1;
        else
            test(i,1) = 0;
        end
    end
    Y = [ones(size(testData_neg,1),1)*0; ones(size(testData_pos,1),1)*1];
    acc(n) = size(find((Y-test)==0),1)/N;
end

plot(dim,smooth(acc,10),'LineWidth',2);
ylabel('Accuracy');
xlabel('Dimension');
title('Reduced Dimension Selection - Neural Network');


%% Dimension _Bayes

clear all; close all;
load 'gist.mat'
testData_pos = trainData_pos(301:500,:);
testData_neg = trainData_neg(301:500,:);

trainData_pos = trainData_pos(1:300,:);
trainData_neg = trainData_neg(1:300,:);

dim = [5:5:40, 50:20:150];
acc = [];
for n = 1 : size(dim,2)

    [ PCs ] = PCA( vertcat(trainData_neg, trainData_pos), dim(n) );
    [ pd, prior] = BayesTrain( trainData_neg, trainData_pos, dim(n), 'Normal' );
    
    testData = vertcat(testData_neg, testData_pos);
    data_DR = (PCs' * testData')';

    Y_hat = BayesPredict(data_DR , pd, prior);

    % convert to 0-1
    hn = size(testData,1)/2;
    meanNeg = mean(Y_hat(1:hn,1));
    Y_hat2 = Y_hat - meanNeg;
    meanPos = mean(Y_hat2(hn+1:end,1));
    Y_hat2 = Y_hat2/meanPos;

    for i = 1 : 2*hn
        if(Y_hat2(i,1)<0)
            Y_hat2(i,1) = 0;
        end

        if(Y_hat2(i,1)>1)
            Y_hat2(i,1) = 1;
        end
    end


    N = size(testData,1);
    test = [];
    for i = 1 : N
        if(Y_hat2(i,1)>0.5)
            test(i,1) = 1;
        else
            test(i,1) = 0;
        end
    end
    Y = [ones(size(testData_neg,1),1)*0; ones(size(testData_pos,1),1)*1];
    acc(n) = size(find((Y-test)==0),1)/N;
end
figure
plot(dim(1,2:10),smooth(acc(2:10),1),'LineWidth',2);
ylabel('Accuracy');
xlabel('Dimension');
title('Reduced Dimension Selection - Bayes Prediction');











