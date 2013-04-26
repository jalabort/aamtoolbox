clear all
close all
clc

pathA = 'C:\Users\ja310\Desktop\2DDFMs\AnnotatedFaceImageDataBases\Helen\TestAnnotations\Originals\';

list = dir([pathA '*.txt']);
n = length(list);
idList = {};

for i = 1:n
  idList = union(idList,list(i).name(1:end-4));
  fprintf(1,'%d/%d\n',i,n);
end