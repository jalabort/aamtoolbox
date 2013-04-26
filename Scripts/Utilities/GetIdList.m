clear all
close all
clc

pathA = '..\AnnotatedFaceImageDataBases\Helen\TrainImages\';

list = dir([pathA '*.jpg']);
n = length(list);
idList = {};

for i = 1:n
  idList = union(idList,list(i).name(1:end-4));
  fprintf(1,'%d/%d\n',i,n);
end