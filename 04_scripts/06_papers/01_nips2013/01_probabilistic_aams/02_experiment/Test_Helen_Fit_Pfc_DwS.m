%% Load or Create M_2D

% shared options
Shared_Model_LFPW


%% Create F_2D

% specific options
opt.fitter = 'p-fc-dws';

% shared options
Shared_Fitter_LFPW
 

%% Fit DS

opt.ann_root =  ...
  ['..' filesep, ... 
   'result' filesep, ...
   'nips2013' filesep, ...
   'probaams' filesep, ...
   'dws' filesep];
opt.img_root =  ...
  [opt.ann_root, ... 
   'img' filesep];

% shared options
Shared_Fit_LFPW


%% Test DS

% shared options
Shared_Test_LFPW

