clear all
close all
clc


%% Test FD_MAT

disp('- FD_Mat test');

% specify database
bin_root = ['..' ...
  filesep 'binarydb' ...
  filesep];
name = 'lfpw';
type = 'train';
ann = 'our';
db = DB([name '-' type '-' ann],bin_root);

% number of image
n_data = 1;

% get dataset
id = 1:n_data;
reg_exp_query = db.RegExpQuery(id);
ds = db.Load(reg_exp_query);

% create FD_MAT face detector
fd = FD_Mat();

img = ds.data{1}.img;
[ann,detected,q] = fd.Run(sm,img,[]);

% test
assert(detected)
disp('  passed');

