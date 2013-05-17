clear all
close all
clc


%% Test PCA_Cent

disp('- PCA_Cent test');

% create pca object
pca = PCA_Cent();

% Create random data
data = randn(1000,50);

% pca from data
[mu,pc,ev] = pca.Compute(data);

% pca covariance matrix
n_data = size(data,2);
mu2 = mean(data,2);
cent_data = data - repmat(mu,[1,n_data]);
cov = pca.ComputeCovMatrix(cent_data);
[pc2,ev2] = pca.ComputeFromCov(cov,cent_data);

% test
tolerance = 10^-10;
assert(all(mu==mu2) && all(pc(:)-pc2(:)<tolerance*ones(size(pc(:)))) && all(ev-ev2<tolerance*ones(size(ev))))
disp('  passed');


%% Test PCA_Noncent

clear all

disp('- PCA_Noncent test');

% create pca object
pca = PCA_Noncent();

% Create random data
data = randn(1000,50);

% pca from data
[~,pc,ev] = pca.Compute(data);

% pca covariance matrix
cov = pca.ComputeCovMatrix(data);
[pc2,ev2] = pca.ComputeFromCov(cov,data);

% test
tolerance = 10^-10;
assert(all(pc(:)-pc2(:)<tolerance*ones(size(pc(:)))) && all(ev-ev2<tolerance*ones(size(ev))))
disp('  passed');


 %% Test PCA_Noncent
 
% clear all
% 
% % create pca object
% pca = WLCPCA();
% 
% % Create random data
% data = randn(1000,50);
% 
% % pca from data
% [~,pc,ev] = pca.Compute(data);
% 
% % pca covariance matrix
% cov = pca.ComputeCovMatrix(data);
% [pc2,ev2] = pca.ComputeFromCov(cov,data);
% 
% % test
% tolerance = 10^-10;
% disp('- PCA_Noncent test');
% assert(all(pc(:)-pc2(:)<tolerance*ones(size(pc(:)))) && all(ev-ev2<tolerance*ones(size(ev))))
% disp('  passed');

