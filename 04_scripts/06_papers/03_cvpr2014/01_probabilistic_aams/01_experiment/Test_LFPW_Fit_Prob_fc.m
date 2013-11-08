%% Load or Create M_2D

% shared options
Shared_Model_LFPW


%% Create F_2D

% specific options
opt.fitter = 'p-sc-dts-dws';

% shared options
Shared_Fitter_LFPW
 

%% Fit DS

% save directories
opt.ann_root =  ...
  ['..' filesep, ... 
   'results' filesep, ...
   'cvpr2014' filesep, ...
   'probabilistic_aams' filesep, ...
   'supplementary' filesep];
opt.img_root =  ...
  [opt.ann_root, ... 
   'img' filesep];

% shared options
Shared_Fit_LFPW


%% Test DS

% shared options
Shared_Test_Fit_LFPW

