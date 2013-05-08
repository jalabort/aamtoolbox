writerObj = VideoWriter('old_joker_1.avi');
writerObj.FrameRate = 20;
writerObj.Quality = 100;
open(writerObj)

for k = 1:1000 
  img = imread(['./' data(k).name]);
%   displayparts(1,img,t_anns(:,:,k),train_db.parts,train_db.n_parts,'green');
imshow(img,[])
  frame = getframe;
  writeVideo(writerObj,frame);
end

close(writerObj);