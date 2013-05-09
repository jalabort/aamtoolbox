clear all
close all
clc


%% Build lfpw binary databases

bin_root = ['..' filesep 'binarydb' filesep];
name = 'helen';
type = 'train';
ann = 'original';
db = DB([name '-' type  '-' ann],bin_root);

img_path = [filesep 'data' filesep 'db' filesep name filesep 'images' filesep type filesep];
ann_path = [filesep 'data' filesep 'db' filesep name filesep 'annotations'  filesep ann filesep type filesep];
img_type = 'jpg';
ann_type = 'txt';
n_vert = 194;
n_ch = 3;
scale = 1;

db.Build(scale,img_path,ann_path,img_type,ann_type,n_vert,n_ch);

