% database
opt.bin_root = ...
  ['..' filesep, ... 
   'binarydb' filesep];
opt.name = 'helen-rescaled';
opt.type = 'test';
opt.ann = 'original';
test_db = DB([opt.name '-' opt.type '-' opt.ann],opt.bin_root);

% test dataset
opt.id = 1:test_db.n_data;
opt.reg_exp_query = test_db.RegExpQuery(opt.id);

% control options
opt.parallel = false;
opt.save_ann = false;
opt.verbose = true;
opt.show = true;
opt.save_img = false;

% fit dataset
Fit_DS