%% read raw data
clear all;close all;
file_path = './CarData/TrainImages/pos/';
[ trainData_pos ] = ReadTrainingData( file_path, '*.pgm' );

file_path = './CarData/TrainImages/neg/';
[ trainData_neg ] = ReadTrainingData( file_path, '*.pgm' );
% 
% close all
% I = imread('pos-0.pgm');
%  image = imcrop(I,[18,8,64,24]);
% imshow(I)
% figure 
% imshow(image)

%% logistic regression
clear all;close all;
load 'gist.mat'
D = [100];
acc = [];
for n = 1 : size(D,2)
    dim = D(n);
    times = 1000;

    [ PCs ] = PCA( vertcat(trainData_neg, trainData_pos), dim );
    [ W, ~ ] = LogisticRegressionTrain( ...
        trainData_neg, trainData_pos, PCs, times);

%     testData = vertcat(testData_neg,testData_pos);
    testData = vertcat(trainData_neg,trainData_pos);
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
    Y = [ones(size(trainData_neg,1),1)*0; ones(size(trainData_pos,1),1)*1];
    acc(n) = size(find((Y-test)==0),1)/N;
end

plot(D,acc);

trainData_neg = double(trainData_neg);
trainData_pos = double(trainData_pos);


%% Neural Network
clear all;close all;
load 'gist.mat'
dim = 100;
learnRate = 0.5;
times = 100;
[ W_ij, W_jk ] = NeuralNetworkTrain(  trainData_neg, trainData_pos, dim, learnRate, times );

testData = vertcat(trainData_neg,trainData_pos);
Y_hat = NeuralNetworkPredict( testData, W_ij, W_jk );
plot(Y_hat);

Y = [ones(size(trainData_neg,1),1)*0; ones(size(trainData_pos,1),1)*1];
test = [];
for i = 1 : size(Y,1)
    if(Y_hat(i,1)>0.90)
        test(i,1) = 1;
    else
        test(i,1) = 0;
    end
end
figure;
plot(test);


%% Bayes
clear all;close all;
load 'gist.mat'

% train:
dim = 25 ;
[ pd, prior] = BayesTrain( trainData_neg, trainData_pos, dim, 'Normal' );

% testing:
testData = vertcat(trainData_neg, trainData_pos);
[ PCs ] = PCA( testData, dim );
data_DR = (PCs' * testData')';

Y_hat = BayesPredict(data_DR , pd, prior);

% 
% n = size(testData,1)/2;
% meanNeg = mean(Y_hat(1:n,1));
% Y_hat2 = Y_hat - meanNeg;
% meanPos = mean(Y_hat2(n+1:end,1));
% Y_hat2 = Y_hat2/meanPos;
% 
% for i = 1 : 2*n
%     if(Y_hat2(i,1)<0)
%         Y_hat2(i,1) = 0;
%     end
% 
%     if(Y_hat2(i,1)>1)
%         Y_hat2(i,1) = 1;
%     end
% end
% 
Y_hat2 = exp(Y_hat);
figure
plot(Y_hat2)




% 
% 
% % testing:
% dim = 10;
% testData = vertcat(trainData_neg, trainData_pos);
% [ PCs ] = PCA( testData, dim );
% data_DR = (PCs' * testData')';
% 
% %normalization
% data_DR = data_DR - (min(min(data_DR)));
% data_DR = data_DR/(max(max(data_DR)));
% 
% trainData = double(vertcat(trainData_neg, trainData_pos));
% label = zeros(size(data_DR(:,1),1),1);
% pf = zeros(size(data_DR(1,:),2),1);
% for i = 1 : size(trainData_neg(:,1),1)
%     label(i,1) = 0;
% end
% py1 = (size(trainData_pos(:,1),1)+1)/(size(data_DR(:,1),1)+2);
% py2 = (size(trainData_neg(:,1),1)+1)/(size(data_DR(:,1),1)+2);
% Y = zeros(size(data_DR(:,1),1),1);
% 
% for n = 1:size(data_DR(:,1),1)
%     p1 = 1;
%     p2 = 1;
%     
%      % neg
%     for j = 1 : size(data_DR(1,:),2)
%         pd = fitdist(data_DR(1:size(trainData_neg(:,1),1),j),'Normal');
%         p2 = p2 * cdf('norm',data_DR(n,j),pd.mu,pd.sigma);
%     end
%     
%     % pos
%     for x = 1 : size(data_DR(1,:),2)
%         pd = fitdist(data_DR(size(trainData_neg(:,1),1)+1:size(data_DR(:,1),1),x),'Normal');
%         p1 = p1 * cdf('norm',data_DR(n,x),pd.mu,pd.sigma);
%     end
%     Y(n,1) = p1*py1/(p1*py1+p2*py2);
% end
%  plot(Y);
 
 
 
 
 
 
 
 
 
 
 