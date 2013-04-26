clear all
close all
clc

pathA = '../AnnotatedFaceImageDataBases/Helen/TrainImages/';
pathB = '../AnnotatedFaceImageDataBases/Helen/TrainImagesOur/';
pathC = '../AnnotatedFaceImageDataBases/Helen/TrainAnnotations/Our/';

list = dir([pathC '*.pts']);
n = length(list);

for i = 1:n
  img = imread([pathA list(i).name(1:end-4) '.jpg']);
  imwrite(img,[pathB list(i).name(1:end-3) 'png'],'PNG');
  fprintf(1,'%d/%d\n',i,n);
end

