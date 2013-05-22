clear all
close all
clc


%% Load or Create M_2D

disp('- F_2D test');

% database
opt.m.bin_root = ...
  ['..' filesep, ... 
   'binarydb' filesep];
opt.m.name = 'lfpw';
opt.m.type = 'train';
opt.m.ann = 'our';
train_db = DB([opt.m.name '-' opt.m.type '-' opt.m.ann],opt.m.bin_root);

% training dataset
opt.m.id = 1:811;
opt.m.reg_exp_query = train_db.RegExpQuery(opt.m.id);

% model options
opt.m.root = ...
  ['..' filesep, ...
   'model' filesep];
opt.m.level = ...
  {1, ...
   0.5, ...
   0.25};
opt.m.erode1 = {1};
opt.m.erode2 = {2};
opt.m.warp = {'pwa'};
opt.m.interp = {'nearest'};
opt.m.smoother = {};
opt.m.sigma = {};
opt.m.shape_model = {'gsm-euler-real-nwarp'};
opt.m.tex_model = {'igo-real-double'};
opt.m.alpha = {};

% build ...M... model
Build_M_From_DS


%% Test F_2D

% database
opt.bin_root = ...
  ['..' filesep, ... 
   'binarydb' filesep];
opt.name = 'lfpw';
opt.type = 'test';
opt.ann = 'our';
test_db = DB([opt.name '-' opt.type '-' opt.ann],opt.bin_root);

% training dataset
opt.id = 1:224;
opt.reg_exp_query = test_db.RegExpQuery(opt.id);

% fitter options
opt.n_it = 50; 
opt.n_c = ... % # of appearance eigenvectors
  {50, ...
   50, ...
   50}; 
opt.n_b = ... % # of mass shape eigenvectors 
  {12, ...
   6, ...
   3}; 
opt.fitter = 'aic-ssd';
opt.detector = 'gr-tr';
opt.rotation = false;
opt.composition_interface = {'papandreou'};

% control options
opt.show = true;
opt.verbose = true;

% build ...F... fitter
Build_F_From_M

