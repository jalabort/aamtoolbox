%% Load or Create M_2D

% shared options
Shared_Model_Helen


%% Create F_2D

% specific options
opt.fitter = 'pbc-ssd';

% shared options
Shared_Fitter_Helen
 

%% Fit DS

opt.ann_root =  ...
  ['..' filesep, ... 
   'result' filesep, ...
   'nips2013' filesep, ...
   'probaams' filesep, ...
   'aic' filesep];
opt.img_root =  ...
  [opt.ann_root, ... 
   'img' filesep];

% shared options
Shared_Fit_Helen


%% Test DS

% shared options
Shared_Test_Fit_Helen

