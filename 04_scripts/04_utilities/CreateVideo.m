pathA = '/data/matlab/aams/data/helen/';
pathB = '/data/matlab/aams/results/cvpr2014/probabilistic_aams/supplementary/img/';

% writerObj = VideoWriter(pathB);
% writerObj.FrameRate = 20;
% writerObj.Quality = 100;
% open(writerObj)

list = dir([pathA '*.jpg']);
n = length(list);

for k = 1:n
  img = imread([pathA list(k).name]);
  [img,ann,~] = normalizefacesize(img,fann(:,:,k*10-1),f.sm{1});
  aamshow(1,img,ann,test_db.parts);
  drawnow
  print(1, '-dpng', '-opengl', [opt.img_root int2str(k) '.png']);
%   aamshow(1,img,fann(:,:,k),test_db.parts);
%   frame = getframe;
%   writeVideo(writerObj,frame);
end

close(writerObj);