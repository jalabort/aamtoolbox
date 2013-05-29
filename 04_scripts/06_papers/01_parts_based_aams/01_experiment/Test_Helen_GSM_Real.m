clear all
close all
clc


%% Load or Create M_2D

% specific options
opt.m.shape_model = {'gsm-real-concat'};

% shared options
Shared_Model_Helen


%% Create F_2D

% specific options
opt.n_b = ... % # of shape eigenvectors 
  {25, ...
   15, ...
   10};   

% shared options
Shared_Fitter_Helen
 

%% Fit DS

% shared options
Shared_Fit_Helen


%% Test DS

% shared options
Shared_Test_Helen

