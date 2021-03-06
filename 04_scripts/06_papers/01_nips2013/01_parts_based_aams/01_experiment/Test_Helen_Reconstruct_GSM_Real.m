%clear all
%close all
clc


%% Load or Create M_2D

% specific options
opt.m.shape_model = {'gsm-real-concat'};

% shared options
Shared_Model_Helen


%% Create F_2D

% specific options
opt.n_b = ... % # of shape eigenvectors 
  {12, ...
   6, ...
   4};   

% shared options
Shared_Fitter_Helen
 

%% Fit DS

% save directories
opt.ann_root =  ...
  ['..' filesep, ... 
   'result' filesep, ...
   'nips2013' filesep, ...
   'global' filesep];
opt.img_root =  ...
  [opt.ann_root, ... 
   'img' filesep];

% shared options
Shared_Reconstruct_Helen


%% Test DS

% shared options
Shared_Test_Reconstruct_Helen

