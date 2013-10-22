% database
opt.bin_root = ...
  ['..' filesep, ... 
   'binarydb' filesep];
opt.name = 'helen-rescaled';
opt.type = 'test';
opt.ann = 'original';
test_db = DB([opt.name '-' opt.type '-' opt.ann],opt.bin_root);

% folder
path = ['..' filesep 'data' filesep opt.name filesep];

% control options
opt.parallel = false;
opt.save_ann = false;
opt.verbose = true;
opt.show = true;
opt.save_img = false;

Fit_from_Folder