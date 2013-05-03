clear all
close all
clc

nLight = '07';

pathA = 'C:\Users\ja310\Desktop\2DAOMs\AnnotatedFaceImageDataBases\MultiPIE\Annotations\';
pathB = 'C:\Users\ja310\Desktop\2DAOMs\AnnotatedFaceImageDataBases\MultiPIE\';
pathC = ['C:\Users\ja310\Desktop\2DAOMs\AnnotatedFaceImageDataBases\MultiPIE\light_' nLight];

list = dir([pathA '*.pts']);
n = length(list);

for i = 1:n
  movefile([pathB strtok(list(i).name, '.') '_' nLight '.png'],pathC)   
  fprintf(1,'%d/%d\n',i,n);
end