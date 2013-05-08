clear all
close all
clc

pathA = 'C:\Users\ja310\Desktop\2DDFMs\AnnotatedFaceImageDataBases\Helen\TestAnnotations\';

list = dir([pathA '*.txt']);
n = length(list);
idList = {};

for i = 1:n
  if length(list(i).name(1:end-4)) == 1
    idList = union(idList,['000' list(i).name(1:end-4)]);
  elseif length(list(i).name(1:end-4)) == 2
    idList = union(idList,['00' list(i).name(1:end-4)]);
  elseif length(list(i).name(1:end-4)) == 3
    idList = union(idList,['0' list(i).name(1:end-4)]);    
  else
    idList = union(idList,list(i).name(1:end-4));    
  end
  fprintf(1,'%d/%d\n',i,n);
end