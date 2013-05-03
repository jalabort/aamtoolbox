clear all
close all
clc

Type = 'TrainImages\';

pathA = 'C:\Users\ja310\Desktop\2DDFMs\AnnotatedFaceImageDataBases\Helen\TrainAnnotations\';
pathB = ['C:\Users\ja310\Desktop\2DDFMs\AnnotatedFaceImageDataBases\Helen\' Type];


list = dir([pathA '*.txt']);
n = length(list);

for i = 1000:n
  if length(list(i).name(1:end-4)) == 1
    movefile([pathB strtok(list(i).name,'.') '.jpg'],[pathB '000' strtok(list(i).name,'.') '.jpg']);  
    movefile([pathA list(i).name],[pathA '000' list(i).name]);  
  elseif length(list(i).name(1:end-4)) == 2
    movefile([pathB strtok(list(i).name,'.') '.jpg'],[pathB '00' strtok(list(i).name, '.') '.jpg']);  
    movefile([pathA list(i).name],[pathA '00' list(i).name]);  
  elseif length(list(i).name(1:end-4)) == 3
    movefile([pathB strtok(list(i).name,'.') '.jpg'],[pathB '0' strtok(list(i).name, '.') '.jpg']);  
    movefile([pathA list(i).name],[pathA '0' list(i).name]);     
  end
  fprintf(1,'%d/%d\n',i,n);
end