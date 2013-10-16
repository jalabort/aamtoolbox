%clear all
close all
clc


%% Test DS

disp('- DS test');

% specify database
bin_root = ['..' ...
  filesep 'binarydb' ...
  filesep];
name = 'ibug';
type = 'test';
ann = 'our';
db = DB([name '-' type '-' ann],bin_root);

% number of image
n_data = 135;

% get dataset
id = 1:n_data;
reg_exp_query = db.RegExpQuery(id);
ds = db.Load(reg_exp_query);

% test
assert(ds.n_data==n_data)
disp('  passed');