clear all
close all
clc

Type = 'TrainImages\';

pathA = 'C:\Users\ja310\Desktop\2DDFMs\AnnotatedFaceImageDataBases\Helen\TrainAnnotations\';
pathB = ['C:\Users\ja310\Desktop\2DDFMs\AnnotatedFaceImageDataBases\Helen\' Type];
pathC = 'C:\Users\ja310\Desktop\helen\';

list = dir([pathA '*.txt']);
n = length(list);

for i = 2032:n
  fid = fopen([pathA list(i).name]);
  tline = fgetl(fid);
  copyfile([pathC tline '.jpg'],[pathB strtok(list(i).name, '.') '.jpg'])   
  fprintf(1,'%d/%d\n',i,n);
end