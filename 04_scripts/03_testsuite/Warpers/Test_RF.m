clear all
close all
clc


%% Test RF

disp('- RF test');

% specify database
bin_root = ['..' ...
  filesep 'binarydb' ...
  filesep];
name = 'lfpw';
type = 'train';
ann = 'our';
db = DB([name '-' type '-' ann],bin_root);

% number of image
n_data = 100;

% get dataset
id = 1:n_data;
reg_exp_query = db.RegExpQuery(id);
ds = db.Load(reg_exp_query);

% create reference frame RF
ref_ann = ds.ComputeRefAnn(); 
parts = ds.parts; 
erode1 = 1; 
erode2 = 2;
rf = RF(ref_ann,parts,erode1,erode2);

% test
assert(rf.n_vert==ds.n_vert && ...
  rf.n_parts==ds.n_parts && ...
  rf.n_pixels>rf.n_face_pixels1 && ...
  rf.n_face_pixels1>rf.n_face_pixels2 && ... 
  length(rf.xy) == rf.n_face_pixels1)
disp('  passed');

