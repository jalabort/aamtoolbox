clear all
close all
clc

load('../model/shapemodel/lfpw_our_gsm-real-nwarp_0_pwa__dd4365bdf4a21085786ea73330a22219.mat')
sm = obj;
clear obj

pathA = '/data/databases/ibug/images/test/';
pathB = '/data/databases/ibug/annotations/our/test/';
pathC = '/data/databases/combined-rescaled/images/train/';
pathD = '/data/databases/combined-rescaled/annotations/our/train/';

list = dir([pathB '*.pts']);
n = length(list);

for i = 1:n
  img = imread([pathA list(i).name(1:end-4) '.jpg']);
  ann = annread([pathB list(i).name],68);
  
  [img,ann,scale] = normalizefacesize(img,ann,sm);
  
  imwrite(img,[pathC list(i).name(1:end-4) '.jpg'],'JPG');
  writepts(pathD,list(i).name,ann,68)
  
  fprintf(1,'%d/%d\n',i,n);
end

