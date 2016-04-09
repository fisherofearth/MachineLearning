%%
% Author: 
%   Xi Yu
%   Xiaotao Yang
%   Yueting Zhu

close all
data = trainData;
data = NormalizeMatrix(data);

ww0 = zeros(45,1);
learningRates = 0.01; 
lambda =0.056;
limit = 10000; 
T_converge = 0.00001; % Threshold of convergance

ww = zeros(45,7);
rec_SSE = zeros(limit,1);
rec_gradient = zeros(limit,1);

[rec_SSE(:,1), rec_gradient(:,1), ww, learningTime] = BatchGradient(data, ww0, learningRates, lambda, limit, T_converge);

plot(rec_SSE(1:learningTime,:));
title('SSE');
clearvars xx yy  lambda gradentE data converganceT learningRate 
min(rec_SSE)
%% 1.
close all
data = trainData;
data = NormalizeMatrix(data);
ww0 = zeros(45,1);
% learningRates = 0.01; 
lambda = 0.032;
limit = 10000; 
T_converge = 0.00001; % Threshold of convergance

ww = zeros(45,7);
rec_SSE = zeros(limit,4) * nan;
rec_gradient = zeros(limit,4);
rec_learningTime = zeros(4,1);

learningRates = [0.01;0.005;0.0025;0.00125]*10;
for lt = 1 :4
    [rec_SSE(:,lt), rec_gradient(:,lt), ww, rec_learningTime(lt,1)] = BatchGradient(data, ww0, learningRates(lt,1), lambda, limit, T_converge);
end

plot(rec_SSE(1:max(rec_learningTime),:));
title('SSE');
clearvars xx yy  lambda gradentE data converganceT learningRate 
rec_learningTime

%% 2
close all
data = trainData;
data = NormalizeMatrix(data);
ww0 = zeros(45,1);
learningRates = 0.01; 
limit = 10000; 
T_converge = 0.00001; % Threshold of convergance

rec_SSE = zeros(limit,7);
rec_gradient = zeros(limit,7);
ww = zeros(45,7);
lambda = [0; 0.001; 0.01; 0.1;1; 10; 100];
rec_SSE_train = [];
xx = data(:,1:45);
yy = data(:,46);
for lt = 1 :7
    [rec_SSE(:,lt), rec_gradient(:,lt), ww(:,lt)] = BatchGradient(data, ww0, learningRates, lambda(lt,1), limit, T_converge);
    rec_SSE_train(lt,1) = (yy - (xx * ww(:,lt)))' * (yy - (xx * ww(:,lt))) * 0.5;
end 

plot(rec_SSE_train(1:6,:));
title('SSE');
clearvars xx yy   gradentE data converganceT learningRate 

rec_SSE_test = [];
xx = testData(:,1:45);
yy = testData(:,46);
for tt = 1 : 7
    rec_SSE_test(tt,1) = (yy - (xx * ww(:,tt)))' * (yy - (xx * ww(:,tt))) * 0.5;
end
figure;
plot(rec_SSE_test(1:6,:));


%% 3
data = trainData;
data = NormalizeMatrix(data);

ww0 = zeros(45,1);
learningRates = 0.01; 
limit = 10000; 
T_converge = 0.0001; % Threshold of convergance
num_lambda =50;


ww = zeros(45,num_lambda);
rec_learningTime = zeros(4,1);
rec_SSE = zeros(limit,num_lambda);

% initial lambda seq
lambda = zeros(num_lambda,1);
for cl = 1:num_lambda-1
    lambda(cl+1,1) =  0.008 * cl;
end

% for each lambda
rec_SSE_lambda = zeros(num_lambda,1);
rec_SSE_lambda_train= zeros(num_lambda,1);
for cl = 1 : num_lambda
    for k = 1 : 10
        % seprate data 
        testD = data( (k-1)*10+1:k*10, :);
        trainD = data;
        trainD( (k-1)*10+1:k*10, :) = [];
        
        % Train 9 fold
        [rec_SSE(:,cl), rec_gradient, ww,learningTime] = BatchGradient(trainD, ww0, learningRates, lambda(cl,1), limit, T_converge);
        learningTime
        % Test the remaining fold
        xx = testD(:,1:45);
        yy = testD(:,46);
        SSE_k= (yy - (xx * ww))' * (yy - (xx * ww)) * 0.5;
        rec_SSE_lambda(cl,1) = rec_SSE_lambda(cl,1) + SSE_k;
        
        xx = trainD(:,1:45);
        yy = trainD(:,46);
        SSE_k= (yy - (xx * ww))' * (yy - (xx * ww)) * 0.5;
        rec_SSE_lambda_train(cl,1) = rec_SSE_lambda_train(cl,1) + SSE_k;
        
        
    end
    
end

close all
plot(lambda,rec_SSE_lambda_train);
figure
plot(lambda,rec_SSE_lambda);
[a,b] = min(rec_SSE_lambda)



















