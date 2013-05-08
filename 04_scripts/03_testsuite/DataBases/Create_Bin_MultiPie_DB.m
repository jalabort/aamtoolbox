clear all
close all
clc

light = '06';
bin_root = '..\BinaryDataBases\';
name = ['MultiPIE-Light' light];

db = DB_MultiPie(name,bin_root);

img_path = ['..\AnnotatedFaceImageDataBases\MultiPIE\Light_' light '\'];
ann_path = '..\AnnotatedFaceImageDataBases\MultiPIE\Annotations\Ours\';
img_type = 'png';
ann_type = 'pts';
n_vert = 68;
n_ch = 3;
scale = 1;

db.Build(scale,img_path,ann_path,img_type,ann_type,n_vert,n_ch);
