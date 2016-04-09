%% implimentation assignment 3
% Topic: Ensemble of Decision Stumps
% Author: Xi Yu
% Date: 11/14/2015

load data
maxNumber_stump = 100;

%% Learn a decision tree stump 
[ classifier, maxInfo, InfoG, classCount ] = Learn( SPECTtrain );
[ accuracy_Train ] = Accuracy( SPECTtrain, classifier );
[ accuracy_Test ] = Accuracy( SPECTtest, classifier );

%% Baging
S = SPECTtrain;
S_test = SPECTtest;
num_Tree = 5:5:maxNumber_stump;
ttt =1 ;
ER_Train = [];
ER_Test = [];
for T = num_Tree
    acc = zeros(10,1);
    acc_test = zeros(10,1);
    e = zeros(10,1);
    e_test = zeros(10,1);
    for run = 1 : 10
        h = zeros(3,T);
        majorityVote = zeros(T,1);
        for t = 1 : T
            [ h(:,t), ~, ~, ~ ] ...
                = LearnD(BootstrapSample(S, length(S)),ones(80,1)/80);      
        end
        [ acc(run, 1), e(run, 1) ] = AccuracyBagging( S, h );
        [ acc_test(run, 1), e_test(run, 1) ] = AccuracyBagging( S_test, h );
    end
    ER_Train(ttt) = mean(e);
    ER_Test(ttt) = mean(e_test);
    ttt  = ttt +1;
end

%% Adaboost
L = maxNumber_stump;
[ h , alpha, e, D] = AdaBoost( SPECTtrain, L );
accuracy_Train = [];
accuracy_Test = [];
for l = 1 : L
    [ accuracy_Train(l,1) ] ...
        = AccuracyAdaBoost( SPECTtrain,h(:,1:l),alpha(1:l,1),D);
    [ accuracy_Test(l,1) ] ...
        = AccuracyAdaBoost( SPECTtest,h(:,1:l),alpha(1:l,1),D);        
end

%% Figuring 
close all
figure
plot(InfoG','LineWidth',2);
ylabel('Information gain');
xlabel('Binary feature');
title('Information gain of decision stump');

figure
plot(num_Tree,[ER_Train; ER_Test; 1-accuracy_Train(num_Tree)'; 1-accuracy_Test(num_Tree)'],'LineWidth',2);
ylabel('Error rate');
xlabel('Ensemble varies');
title('Training and testing errors');
legend('Training -Bagging',...
    'Testing -Bagging',...
    'Training -AdaBoost',...
    'Testing -AdaBoost')

figure
plot(num_Tree,[1-ER_Train; 1-ER_Test; accuracy_Train(num_Tree)'; accuracy_Test(num_Tree)'],'LineWidth',2);
ylabel('Accuracy');
xlabel('Ensemble varies');
title('Training and testing Accuracy');
legend('Training -Bagging',...
    'Testing -Bagging',...
    'Training -AdaBoost',...
    'Testing -AdaBoost')

figure
plot([smooth((1-accuracy_Train)*80,10) smooth((1-accuracy_Test)*187,10)],'LineWidth',2);
ylabel('error');
xlabel('L');
title('Error');
title('Training and testing Errors');
legend('Training -AdaBoost','Testing -AdaBoost')



%% Figures of epsilon
% figure 
% plot(e);
% ylabel('epsilon');
% xlabel('L');
% title('epsilon');

%% Figures of alpha
% figure 
% plot(alpha);
% ylabel('alpha');
% xlabel('L');
% title('alpha');









