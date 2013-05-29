% database
opt.bin_root = ...
  ['..' filesep, ... 
   'binarydb' filesep];
opt.name = 'helen-rescaled';
opt.type = 'test';
opt.ann = 'original';
test_db = DB([opt.name '-' opt.type '-' opt.ann],opt.bin_root);

% test dataset
opt.id = 1:330;
opt.reg_exp_query = test_db.RegExpQuery(opt.id);

% control options
opt.parallel = false;
opt.show = true;
opt.verbose = true;

Fit_DS