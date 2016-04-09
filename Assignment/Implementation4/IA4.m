%% implimentation assignment 4
% Topic: Dimension Reduction & Clustering
% Author: Xi Yu "Fisher"
% Date: 11/21/2015

%% Load Data
clear all
close all
data = (textread('digits79.txt', '', 'delimiter', ',','emptyvalue', NaN));
label = (textread('digitslabels.txt', '', 'delimiter', ',','emptyvalue', NaN));
                     

%% 1. K-means
close all
K = 2;
times = 15;
[ classes, centers ] = KMeans10( data, K , times);
% Build-in kmeans function:
% classes = kmeans(data,K);

% Compute SSE
SSE  =zeros(10,1);
for i = 1: 10
    error = ((label-5) / 2) - classes(:,i);
    SSE(i,1) = error' * error;
end
figure
plot(SSE,'LineWidth',2)
ylabel('SSE');
xlabel('Test number');
title('SSE');

% Compute class purity 
accuracy = [];
mj_classes=[];
for i = 1: 10
    [ accuracy(:,i), mj_classes(:,i) ] = PurityMeasure( classes(:,i), label );
end

figure
plot(accuracy,'LineWidth',2)
ylabel('Purity');
xlabel('Test number');
title('Class purity');

[bestAccuracy,idx] = max(accuracy);
bestCenter = centers(:,:,idx);
bestCluster = classes(:,idx);
PurityMeasure(bestCluster, label )
clear i idx;

%% 2.PCs
retain = 0.8;
S = Corvariance(data);
% Build-in corvariance function:
% S2 = cov(data);
[eigenvectors, test] = eig(S);
eigenvalues= eig(S);
% Rank by eigen value (direction = descend)
[eigenvalues,I] = sort(eigenvalues,'descend');
eigenvectors = eigenvectors(:,I);
clear I
[ smartestD ] = SmartestD(eigenvalues, retain);
% PCs = eigenvectors(:,1:smartestD);
smartestD

%% 3. PCA
close all

K = 2;
times = 15;

%consider the 1st dimesion
PCs = eigenvectors(:,[1:1]);
data_DR = (PCs' * data')';
[ classes, centers ] = KMeans10( data_DR, K , times);
accuracy = [];
mj_classes=[];
for i = 1: 10
    [ accuracy(:,i), mj_classes(:,i) ] = PurityMeasure( classes(:,i), label );
end
max(accuracy)
figure
plot(accuracy,'LineWidth',2)
ylabel('Purity');
xlabel('Test number');
title('First 1D reflection');

%consider the 1st 2 dimesion
PCs = eigenvectors(:,[1:2]);
data_DR = (PCs' * data')';
[ classes, centers ] = KMeans10( data_DR, K , times);
accuracy = [];
mj_classes=[];
for i = 1: 10
    [ accuracy(:,i), mj_classes(:,i) ] = PurityMeasure( classes(:,i), label );
end
max(accuracy)
figure
plot(accuracy,'LineWidth',2)
ylabel('Purity');
xlabel('Test number');
title('First 2D reflection');

%consider the 1st 3 dimesion
PCs = eigenvectors(:,[1:3]);
data_DR = (PCs' * data')';
[ classes, centers ] = KMeans10( data_DR, K , times);
accuracy = [];
mj_classes=[];
for i = 1: 10
    [ accuracy(:,i), mj_classes(:,i) ] = PurityMeasure( classes(:,i), label );
end
max(accuracy)
figure
plot(accuracy,'LineWidth',2)
ylabel('Purity');
xlabel('Test number');
title('First 3D reflection');


%combination
% 1D
acc_1D = [];
for i = 1: smartestD
    PCs = eigenvectors(:,i);
    data_DR = (PCs' * data')';
    classes = kmeans(data_DR,2);
    [acc_1D(i), ~] = PurityMeasure( classes, label );
end

% 2D
combIdx_2D = nchoosek([1:smartestD],2);
acc_2D = [];
for i = 1: size(combIdx_2D,1)
    PCs = eigenvectors(:,combIdx_2D(i,:));
    data_DR = (PCs' * data')';
    classes = kmeans(data_DR,2);
    [acc_2D(i), ~] = PurityMeasure( classes, label );
end

% 3D
combIdx_3D = nchoosek([1:smartestD],3);
acc_3D = [];
for i = 1: size(combIdx_3D,1)
    PCs = eigenvectors(:,combIdx_3D(i,:));
    data_DR = (PCs' * data')';
    classes = kmeans(data_DR,2);
    [acc_3D(i), ~] = PurityMeasure( classes, label );
end

figure
plot(acc_1D,'LineWidth',2)
ylabel('Purity');
xlabel('idx of combination');
title('1D reflection');

figure
plot(acc_2D,'LineWidth',2)
ylabel('Purity');
xlabel('idx of combination');
title('2D reflection');

figure
plot(acc_3D,'LineWidth',2)
ylabel('Purity');
xlabel('idx of combination');
title('3D reflection');

[purity, i] = max(acc_1D);
[purity, i] = max(acc_2D);
purity
combIdx_2D(i,:)
[purity, i] = max(acc_3D);
purity
combIdx_3D(i,:)


%% 4. LDA
D = size(data,2);
N = size(data,1);
scatterM = zeros(D,D);
idx1 = find(label == 7);
idx2 = find(label == 9);
m = [];
m(:,1) = mean(data(idx1,:))';
m(:,2) = mean(data(idx2,:))';

for i = 1 : N
    xi = data(i,:)';
    c = ((label - 5) / 2);
    scatterM = scatterM + (xi-m(:,c(i)))*((xi-m(:,c(i)))');
end

w = inv(scatterM) * (m(:,1) - m(:,2));
data_1D = (data * w);

class = kmeans(data_1D, 2);
 
% [ classes, centers ] = KMeans(data_1D, 2,15);
% [ classes, centers ] = KMeans10(data_1D, 2, 15);
% 
% acc_LDA=[];
% mj_classes = [];
% for i = 1: 10
%     [acc_LDA(i), mj_classes(:,i)]  = PurityMeasure( classes(:,i), label );
% end
% 














