% database
opt.bin_root = ...
  ['..' filesep, ... 
   'binarydb' filesep];
opt.name = 'lfpw';
opt.type = 'test';
opt.ann = 'our';
test_db = DB([opt.name '-' opt.type '-' opt.ann],opt.bin_root);

% folder
sequence = '1786_02_006_sylvester_stallone';
name = ['youtube' filesep sequence];
path = ['..' filesep 'data' filesep name filesep];
img_type = 'png';
ann_type = 'pts';

% control options
opt.save_ann = false;
opt.verbose = true;
opt.show = true;
opt.save_img = false;

Track_from_Folder