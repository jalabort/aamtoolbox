function [ann,detected,p] = Run(obj,sm,img,~)
  %Run Summary of this function goes here
  %   Detailed explanation goes here
  
  % initialize matlab face detection
  obj.detector.release();
  bbox = step(obj.detector,img);

  if ~isempty(bbox)
    % if detected
    detected = true;
    aux = (max(sm.Shape2Ann(sm.mu)) -  min(sm.Shape2Ann(sm.mu))); %ideally this should be part of sm...
    scale = 0.9 * bbox(end,3) / aux(1); 
    trans = repmat([(bbox(end,1)+bbox(end,3)/2),(bbox(end,2)+bbox(end,4)/1.65)],sm.n_vert,1);
    ann = scale * sm.mu_ann +  trans;
  
    if obj.rotation
      % if rotation flag is on
      p = sm.Ann2SRT(ann);
    else
      % if not
      p = sm.Ann2SRT(ann);
    end
    
  else
    % if not detected
    detected = false; 
    ann = []; p = [];
  end

end

