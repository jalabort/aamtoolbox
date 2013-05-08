clear all
close all
clc

bin_root = '../BinaryDataBases/';
type = 'Train';
ann = 'Original';
name1 = 'Helen';
name2 = [name1 '-' type '-' ann];

db = DB(name2,bin_root);

img_path = ['../AnnotatedFaceImageDataBases/' name1 '/' type 'Images/'];
ann_path = ['../AnnotatedFaceImageDataBases/' name1 '/' type 'Annotations/' ann '/'];
img_type = 'jpg';
ann_type = 'txt';
n_vert = 194;
n_ch = 3;
scale = 1;

db.Build(scale,img_path,ann_path,img_type,ann_type,n_vert,n_ch);

