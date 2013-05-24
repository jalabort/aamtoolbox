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
opt.m.tex_model = {'pi'};
opt.m.alpha = {};

% build ...M... model
Build_M_From_DS

