%% Load or Create M_2D

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
opt.m.warp = {'tps'};
opt.m.interp = {'nearest'};
opt.m.dense = false;
opt.m.smoother = {};
opt.m.sigma = {};
opt.m.shape_model = {'gsm-real-nwarp'};
opt.m.tex_model = {'pi'};
opt.m.alpha = {};

% build ...M... model
Build_M_From_DS


%% Create F_2D

% fitter options
opt.n_it = 50; 
opt.n_c = ... % # of appearance eigenvectors
  {500, ...
   500, ...
   500}; 
opt.n_b = ... % # of shape eigenvectors 
  {12, ...
   6, ...
   3};   
opt.fitter = 'aic-ssd';
opt.detector = 'gr-tr';
opt.rotation = false;
opt.composition_interface = {'papandreou'};

% build ...F... fitter
Build_F_From_M


%% Fit

% database
opt.bin_root = ...
  ['..' filesep, ... 
   'binarydb' filesep];
opt.name = 'lfpw';
opt.type = 'test';
opt.ann = 'our';
test_db = DB([opt.name '-' opt.type '-' opt.ann],opt.bin_root);

% test dataset
opt.id = 1:224;
opt.reg_exp_query = test_db.RegExpQuery(opt.id);

% control options
opt.parallel = false;
opt.save_ann = false;
opt.verbose = true;
opt.show = true;
opt.save_img = false;

Fit_DS

