function [ann,detected,p] = Run(obj,sm,img,~)
  %Run Summary of this function goes here
  %   Detailed explanation goes here
  
  % initialize matlab face detection
  obj.detector.release();
  bbox = step(obj.detector,img);

  if ~isempty(bbox)
    % if detected
    detected = true;
    aux = (max(sm{1}.Shape2Ann(sm{1}.mu)) -  min(sm{1}.Shape2Ann(sm{1}.mu))); %ideally this should be part of sm{1}...
    scale = 1 * bbox(end,3) / aux(1); 
    trans = repmat([(bbox(end,1)+bbox(end,3)/2),(bbox(end,2)+bbox(end,4)/1.65)],sm{1}.n_vert,1);
    ann = scale * sm{1}.mu_ann +  trans;
  
    if obj.rotation
      % if rotation flag is on
      p = sm{1}.Ann2SRT(ann);
    else
      % if not
      p = sm{1}.Ann2SRT(ann);
    end
    
  else
    % if not detected
    detected = false; 
    ann = []; p = [];
  end

end

