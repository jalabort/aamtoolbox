function [ann,q,detected] = Run(obj,~,img,~,default_ann,n_vert,res)
  %RUN Summary of this function goes here
  %   Detailed explanation goes here
  
  obj.face_det.release();
  
  bbox = step(obj.face_det,img);

  if isempty(bbox)
    detected = false; 
    ann = [];
  else
    detected = true;
    scale = 0.9 * bbox(end,3) / res(1);
    trans = repmat([(bbox(end,1)+bbox(end,3)/2),(bbox(end,2)+bbox(end,4)/1.65)],n_vert,1);
    ann = scale * default_ann +  trans;
  end
  
  q = [];

end

