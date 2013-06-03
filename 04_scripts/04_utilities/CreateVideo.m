writerObj = VideoWriter([opt.sequence '.avi']);
writerObj.FrameRate = 20;
writerObj.Quality = 100;
open(writerObj)

for k = 1:1000
  img = imread([opt.folder opt.sequence data(k).name]);
  displayparts(1,img,t_anns(:,:,k),train_db.parts,train_db.n_parts,'green');
  frame = getframe;
  writeVideo(writerObj,frame);
end

close(writerObj);