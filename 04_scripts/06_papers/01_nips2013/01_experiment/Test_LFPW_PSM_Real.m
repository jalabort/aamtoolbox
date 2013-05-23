clear all
close all
clc


%% Load or Create M_2D

% specific options
opt.m.shape_model = {'psm-real-concat'};

% shared options
Shared_Model


%% Create F_2D

% specific options
opt.n_f = ... % # of mass shape eigenvectors 
  {9, ...
   6, ...
   3}; 
opt.n_r = ... % # of local shape eigenvectors
  {3, 0, 0;    % mouth
   2, 0, 0;    % nose
   1, 0, 0;    % left eye
   1, 0, 0;    % right eye
   3, 0, 0;    % jaw
   1, 0, 0;    % left eyebrow
   1, 0, 0};   % right eyebrow  

% shared options
Shared_Fitter
 

%% Fit DS

% shared options
Shared_Fit_LFPW


%% Test DS

% shared options
Shared_Test

