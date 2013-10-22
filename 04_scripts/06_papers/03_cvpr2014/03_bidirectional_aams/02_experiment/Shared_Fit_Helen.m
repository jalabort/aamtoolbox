% database
opt.bin_root = ...
  ['..' filesep, ... 
   'binarydb' filesep];
opt.name = 'lfpw';
opt.type = 'test';
opt.ann = 'our';
test_db = DB([opt.name '-' opt.type '-' opt.ann],opt.bin_root);

path = ['..' filesep 'data' filesep opt.name];

% test dataset
opt.id = 1:test_db.n_data;
opt.reg_exp_query = test_db.RegExpQuery(opt.id);

% control options
opt.parallel = true;
opt.save_ann = false;
opt.verbose = false;
opt.show = true;
opt.save_img = false;

Fit_from_Folder