clear all
close all
clc


%% Load or Create M_2D

% specific options
opt.m.shape_model = {'csm-real-concat'};

% shared options
Shared_Model_Helen


%% Create F_2D

% specific options
opt.n_f = ... % # of mass shape eigenvectors 
  {5, ...
   4, ...
   3}; 
opt.n_r = ... % # of local shape eigenvectors
  {3, 2, 1;    % mouth
   2, 1, 0;    % nose
   1, 0, 0;    % left eye
   1, 0, 0;    % right eye
   3, 1, 0;    % jaw
   1, 0, 0;    % left eyebrow
   1, 0, 0};   % right eyebrow  

% shared options
Shared_Fitter_Helen
 

%% Fit DS

% shared options
Shared_Fit_Helen


%% Test DS

% shared options
Shared_Test_Helen

