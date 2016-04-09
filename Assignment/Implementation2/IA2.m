clear all
load data.mat
load matlab.mat
num_word = 61188;
num_label = 20;

%% trining 
P_wy = Multi(trainData, trainLabel,1);
num_doc = 11269;
P_y = ones(num_label,1) * 0.5;   % prior
for y = 1 : num_label
    P_y(y,1) = size(find(trainLabel == y),1) / num_doc;
end

%% Testing
[outputLable maxValue accuracy runtime ] = TestMultinomial( testData, testLabel, P_wy, P_y);
plotData = [testLabel outputLable ];
plot(plotData);

correctNum = accuracy * 7505
incorrectNum = (1-accuracy) * 7505


%% ------- Bernoulli -------
%% Training
P_wy = zeros(num_word, num_label); %classifier

tic
sumOfWord_y = [];
for y = 1 : num_label
    dgIdx = [find(trainLabel == y, 1, 'first')  find(trainLabel == y, 1, 'last')];
    group = trainData(trainIdx(dgIdx(1),1):trainIdx(dgIdx(2),2) ,2);     
    group = [group ones(size(group,1),1)]; % y = label; [wordID 1]
    sumOfWord_y(y) = sum(group(:,2)) ;
    sumOfWord_iy = [];
    
    for w = 1 : num_word % foreach word
        sumOfWord_iy(w,y) = sum(group(find(group(:,1) == w),2)); % num of word i in label y
        P_wy(w,y) = (sumOfWord_iy(w,y) + 1) / (sumOfWord_y(y) + num_word);
    end       

end

num_doc = size(trainLable,1);
P_y = ones(num_label,1) * 0.5;   % prior
for y = 1 : num_label
    P_y(y,1) = size(find(TrainLabel == y),1) / num_doc;
end
runTime = toc

%% Testing
tic
dataT = testData;
dataT(:,3) = 0;
dataT(:,3) = dataT(:,3)+1;

num_doc = 7505;
result_dy = zeros(num_doc,num_label);

for d = 1 : num_doc 
    doc =dataT(find(dataT(:,1) == d),2:3);
    for y = 1 : num_label
        P_tmp = 0;
        for w = 1:size(doc,1)
            xi = doc(w,2);
            piy = log(P_wy(doc(w,1),y));
            P_tmp = P_tmp + (xi * piy)+ ((1-xi) * (1-piy));
        end
        result_dy(d,y) = P_tmp + log(P_y(y,1));
    end
end
runtime = toc

[maxV outputLable]  = max(result_dy,[],2); 
plotData = [testLabel outputLable ];
plot(plotData);
accuracy = size(find((testLabel - outputLable) == 0),1) / num_doc;

correctNum = accuracy * 7505
incorrectNum = (1-accuracy) * 7505

%% ---- Confusion matrix
num_doc = 7505;
confusionM = zeros(num_label, num_label);
for d1 = 1 : num_doc
    y = testLabel(d1);
%     for d2 = 1 : num_doc
    yhat = outputLable(d1);
    confusionM(y, yhat) = confusionM(y, yhat) + 1;
%     end
end

%% Dirichlet

alpha = [1e-5; 1e-4; 1e-3; 1e-2; 1e-1; 1];
num_doc = 11269;
rec_accuracy = [];
for t = 1 : size(alpha,1)
    P_wy = Multi(trainData, trainLabel,alpha(t,1));
    P_y = [];
    for y = 1 : num_label
        P_y(y,1) = (size(find(trainLabel == y),1)+alpha(t,1)) / (num_doc + (alpha(t,1)*num_label));
    end
    [outputLable maxValue accuracy runtime ] = TestMultinomial( testData, testLabel, P_wy, P_y);
    rec_accuracy(t) = accuracy;
end
log(alpha)
plot(log(alpha),rec_accuracy)


%% Identifying important features
% --------------
countF = zeros(num_word,1);
for i = 1 : size(trainData,1)
    countF(trainData(i,2),1) = countF(trainData(i,2),1) + trainData(i,3);
end
freq = countF/(sum(countF));


tic
Th_H = 0.0001;
Th_L = 1E-5;

shinkedDictIdx = [];
c = 1;
for i = 1 : num_word
    if(freq(i,1)<=Th_H & freq(i,1)>=Th_L)
        shinkedDictIdx(i,1) = c;
        c = c+1;
    else
        shinkedDictIdx(i,1) = 0;
    end
end
newDict = [1:c-1]';

newTrainData = Shrink3( trainData, shinkedDictIdx );
newTestData = Shrink3 (testData, shinkedDictIdx);
% --------------

% training
P_wy = Multi(newTrainData, trainLabel,0.1);
P_y = [];
for y = 1 : num_label
    P_y(y,1) = (size(find(trainLabel == y),1)+0.1) / (num_doc + (0.1*num_label));
end

% testing
[outputLable maxValue accuracy runtime ] = TestMultinomial( newTestData, testLabel, P_wy, P_y);
rec_accuracy(t) = accuracy;
accuracy
toc


%% note
% [docID wordID count]


% % compute idx for train data, [startIdx endIdx]
% trainIdx = [];
% for i = 1: size(trainLabel,1)  
%     trainIdx(i,1) = find(trainData(:,1) == i, 1);
% end
% trainIdx(:,2) = [trainIdx(2:end,1)-1; size(trainData,1)];
% 
% % compute idx for test data, [startIdx endIdx]
% testIdx = [];
% for i = 1: size(testLabel,1) 
%     testIdx(i,1) = find(testData(:,1) == i, 1);
% end
% testIdx(:,2) = [testIdx(2:end,1)-1; size(testData,1)];


% P_wy = zeros(num_word, num_label); %classifier
% 
% tic
% sumOfWord_y = [];
% for y = 1 : num_label
%     dgIdx = [find(trainLabel == y, 1, 'first')  find(trainLabel == y, 1, 'last')];
%     group = trainData(find(trainData(:,1) == dgIdx(1), 1, 'first'):find(trainData(:,1) == dgIdx(2), 1, 'last') ,2:3);  % y = label, docID = doc; [wordID count]    
%     sumOfWord_y(y) = sum(group(:,2)) ;
%     sumOfWord_iy = [];
%     for w = 1 : num_word % foreach word
%         sumOfWord_iy(w,y) = sum(group(find(group(:,1) == w),2)); % num of word i in label y
%         P_wy(w,y) = (sumOfWord_iy(w,y) + 1) / (sumOfWord_y(y) + num_word);
%     end        
% end
% 
% P_y = ones(num_label,1) * 0.5;   % prior
% for y = 1 : num_label
%     P_y(y,1) = size(find(trainLabel == y),1) / num_doc;
% end
% runTime = toc






