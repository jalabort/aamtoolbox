% database
opt.m.bin_root = ...
  ['..' filesep, ... 
   'binarydb' filesep];
opt.m.name = 'helen-rescaled';
opt.m.type = 'train';
opt.m.ann = 'original';
train_db = DB([opt.m.name '-' opt.m.type '-' opt.m.ann],opt.m.bin_root);

% training dataset
opt.m.id = 1:2000;
opt.m.reg_exp_query = train_db.RegExpQuery(opt.m.id);

% model options
opt.m.root = ...
  ['..' filesep, ...
   'model' filesep];
opt.m.level = ...
  {1, ...
   1, ...
   1};
opt.m.erode1 = {0};
opt.m.erode2 = {2};
opt.m.warp = {'pwa'};
opt.m.interp = {'linear'};
opt.m.smoother = {};
opt.m.sigma = {};
opt.m.tex_model = {'pi-norm'};
opt.m.alpha = {};

% build ...M... model
Build_M_From_DS

