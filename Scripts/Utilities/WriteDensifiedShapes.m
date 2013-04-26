clear all
close all
clc

pathA = '..\AnnotatedFaceImageDataBases\Helen\TrainAnnotations\OursHD\';
pathB = '..\AnnotatedFaceImageDataBases\Helen\TrainAnnotations\Ours\';

list = dir([pathA '*.pts']);
n = length(list);

for i = 1:n
  
  ann = annread([pathA list(i).name],68);
  ann = ann./4;
  
  fid=fopen([pathB list(i).name],'w');
  fprintf(fid,'version: 1\n');
  fprintf(fid,'n_points:  68\n');
  fprintf(fid,'{\n');
  
  for j = 1:68
    fprintf(fid,'%f %f\n',ann(j,1),ann(j,2)); 
  end
  
  fprintf(fid,'}');    
  fclose(fid);
  fprintf(1,'%d/%d\n',i,n);
  
end