% database
opt.m.bin_root = ...
  ['..' filesep, ... 
   'binarydb' filesep];
opt.m.name = 'helen';
opt.m.type = 'train';
opt.m.ann = 'our';
train_db = DB([opt.m.name '-' opt.m.type '-' opt.m.ann],opt.m.bin_root);

% training dataset
opt.m.id = 1:train_db.n_data;
opt.m.reg_exp_query = train_db.RegExpQuery(opt.m.id);

% model options
opt.m.root = ...
  ['..' filesep, ...
   'model' filesep];
 
opt.m.shape_model = 'gsm-real-nwarp';
opt.m.dense = false;
opt.m.shape_alpha = [];
opt.m.shape_lp = [];

opt.m.erode1 = 0;
opt.m.erode2 = 1;
opt.m.warp = 'pwa';
opt.m.interp = 'nearest';

opt.m.level = {1,0.5,0.25};
opt.m.smoother = {'gaussian'};
opt.m.sigma = {1,2,4};
opt.m.feature = {'pi'};
opt.m.tex_model = {'cent-norm'};
opt.m.tex_lp = {};
opt.m.tex_alpha = {};

% build ...M... model
Build_M_From_DS

