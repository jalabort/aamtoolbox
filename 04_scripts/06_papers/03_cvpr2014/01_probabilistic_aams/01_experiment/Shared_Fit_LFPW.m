% database
opt.bin_root = ...
  ['..' filesep, ... 
   'binarydb' filesep];
opt.name = 'helen';
opt.type = 'test';
opt.ann = 'our';
test_db = DB([opt.name '-' opt.type '-' opt.ann],opt.bin_root);

path = ['..' filesep 'data' filesep 'villains' filesep];

% test dataset
opt.id = 1:test_db.n_data;
opt.reg_exp_query = test_db.RegExpQuery(opt.id);

% control options
opt.parallel = false;
opt.save_ann = false;
opt.verbose = false;
opt.show = true;
opt.save_img = true;

Fit_from_Folder