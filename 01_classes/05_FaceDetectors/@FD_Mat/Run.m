function [ann,q,detected] = Run(obj,sm,img,~)
  %Run Summary of this function goes here
  %   Detailed explanation goes here
  
  obj.detector.release();
  bbox = step(obj.detector,img);

  if ~isempty(bbox)
    detected = true;
    scale = 0.9 * bbox(end,3) / sm.mu_height;
    trans = repmat([(bbox(end,1)+bbox(end,3)/2),(bbox(end,2)+bbox(end,4)/1.65)],sm.n_vert,1);
    ann = scale * sm.mu_ann +  trans;
    q = sm.Shape2Q(sm.Ann2Shape(ann));
  else
    detected = false; 
    ann = []; q = [];
  end

end

