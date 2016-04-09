%%
num = 93;
%note:
%15-unscale
%93-scale
%2-scale
file_path = './CarData/TestImages_Scale/';
img_path_list = dir(strcat(file_path, '*.pgm'));
image_name = img_path_list(num).name;
image= imread(strcat(file_path, image_name)); 

% imwrite(image,'test2.png')
load 'gist.mat'


%% logistic regression
dim = 200;
times = 800;
LR = 0.05;
[ PCs ] = PCA( vertcat(trainData_neg, trainData_pos), dim );
    [ weights, ~ ] = LogisticRegressionTrain( ...
        trainData_neg, trainData_pos, PCs, times,LR);

H = size(image,1);
W = size(image,2);
resolution = int32(W/10);
M = zeros(H,W); 
uW = int32(resolution);
uH = int32(resolution*(H/W));
R = [int32((W/2)-uW) int32((H/2)-uH) uW*2 uH*2];
NX = int32(W/2/uW) - 2;
NY = int32(H/2/uH) - 2;
for sx = 0 : NX
    for sy = 0: NY
        rect = [(R(1)-(sx*uW))...
                (R(2)-(sy*uH))...
                (R(3)+(sx*uW*2))...
                (R(4)+(sy*uH*2))...
                ];
        M = M + Estimate9Segments_LR( image, rect, PCs, weights);
    end
end
image_LR= image;
figure
imshow(image_LR)

M_LR = M;
figure
imagesc(M_LR)

%% NN
dim = 100;
times = 150;
LR = 0.2;
[ PCs ] = PCA( vertcat(trainData_neg, trainData_pos), dim );
[ W_ij, W_jk ] = NeuralNetworkTrain(  trainData_neg, trainData_pos, dim, LR, times );

    
H = size(image,1);
W = size(image,2);
resolution = int32(W/10);
M = zeros(H,W); 
uW = int32(resolution);
uH = int32(resolution*(H/W));
R = [int32((W/2)-uW) int32((H/2)-uH) uW*2 uH*2];
NX = int32(W/2/uW) - 2;
NY = int32(H/2/uH) - 2;
for sx = 0 : NX
    for sy = 0: NY
        rect = [(R(1)-(sx*uW))...
                (R(2)-(sy*uH))...
                (R(3)+(sx*uW*2))...
                (R(4)+(sy*uH*2))...
                ];
        M = M + Estimate9Segments_NN( image, rect, PCs, W_ij, W_jk );
    end
end
image_NN = image;
figure
imshow(image_NN)

M_NN = M;
figure
imagesc(M_NN)

%% NB
dim = 25;
[ PCs ] = PCA( vertcat(trainData_neg, trainData_pos), dim );
[ pd, prior] = BayesTrain( trainData_neg, trainData_pos, dim, 'Normal' );

trainData = vertcat(trainData_neg, trainData_pos);
data_DR = (PCs' * trainData')';

Y_hat = BayesPredict(data_DR , pd, prior);

% convert to 0-1
hn = size(trainData,1)/2;
meanNeg = mean(Y_hat(1:hn,1));
Y_hat2 = Y_hat - meanNeg;
meanPos = mean(Y_hat2(hn+1:end,1));

    
H = size(image,1);
W = size(image,2);
resolution = int32(W/10);
M = zeros(H,W); 
uW = int32(resolution);
uH = int32(resolution*(H/W));
R = [int32((W/2)-uW) int32((H/2)-uH) uW*2 uH*2];
NX = int32(W/2/uW) - 2;
NY = int32(H/2/uH) - 2;
for sx = 0 : NX
    for sy = 0: NY
        rect = [(R(1)-(sx*uW))...
                (R(2)-(sy*uH))...
                (R(3)+(sx*uW*2))...
                (R(4)+(sy*uH*2))...
                ];
        M = M + Estimate9Segments_NB( image, rect, PCs, pd, prior, meanNeg, meanPos);
    end
end
image_NB = image;
figure
imshow(image_NB)

M_NB = M;
figure
imagesc(M_NB)

close all

figure
imshow(image);
title('Original Image');axis off;


clims = [0 14];
figure
subplot(3,1,1);
imagesc(M_LR,clims);
title('Logistic Regression');axis off;
subplot(3,1,2);
imagesc(M_NN,clims);
title('Neural Networ');axis off;
subplot(3,1,3);
imagesc(M_NB,clims);
title('Naive Bayes');axis off;






figure
image2 = image;
for x = 1 : size(image,2)
    for y = 1: size(image,1)
        if(M_NB(y,x)<7)
            image2(y,x) = 0;
        end
    end
end
imshow(image2);
% title('Logistic Regression');
 title('Naive Bayes');
% 
