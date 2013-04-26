clear all
close all
clc

bin_root = '..\BinaryDataBases\';
type = 'Train';
name = ['LFPW-' type];

db = DB(name,bin_root);

img_path = ['..\AnnotatedFaceImageDataBases\LFPW\' type 'Images\'];
ann_path = ['..\AnnotatedFaceImageDataBases\LFPW\' type 'Annotations\Ours\'];
img_type = 'png';
ann_type = 'pts';
n_vert = 68;
n_ch = 3;

db.Build(img_path,ann_path,img_type,ann_type,n_vert,n_ch);

