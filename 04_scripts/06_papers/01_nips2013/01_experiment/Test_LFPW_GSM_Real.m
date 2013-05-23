clear all
close all
clc


%% Load or Create M_2D

% specific options
opt.m.shape_model = {'gsm-real-concat'};

% shared options
Shared_Model


%% Create F_2D

% specific options
opt.n_b = ... % # of shape eigenvectors 
  {12, ...
   6, ...
   3};   

% shared options
Shared_Fitter
 

%% Fit DS

% shared options
Shared_Fit_LFPW


%% Test DS

% shared options
Shared_Test

