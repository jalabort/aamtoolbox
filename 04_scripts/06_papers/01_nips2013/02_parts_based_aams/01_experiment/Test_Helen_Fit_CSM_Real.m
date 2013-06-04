%clear all
%close all
clc


%% Load or Create M_2D

% specific options
opt.m.shape_model = {'csm-real-concat'};

% shared options
Shared_Model_Helen


%% Create F_2D

% specific options
opt.n_f = ... % # of mass shape eigenvectors 
  {10, ...
   8, ...
   6}; 
opt.n_r = ... % # of local shape eigenvectors
  {3, 2, 1;    % mouth
   2, 1, 1;    % nose
   1, 0, 0;    % left eye
   1, 0, 0;    % right eye
   3, 2, 1;    % jaw
   1, 0, 0;    % left eyebrow
   1, 0, 0};   % right eyebrow  

% shared options
Shared_Fitter_Helen
 

%% Fit DS

% save directories
opt.ann_root =  ...
  ['..' filesep, ... 
   'result' filesep, ...
   'nips2013' filesep, ...
   'partaam' filesep, ...
   'component'];
opt.img_root =  ...
  [opt.ann_root, ... 
   'img' filesep];

% shared options
Shared_Fit_Helen


%% Test DS

% shared options
Shared_Test_Fit_Helen

