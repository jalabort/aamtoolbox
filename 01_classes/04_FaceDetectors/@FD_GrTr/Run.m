function [ann,detected,p] = Run(obj,sm,~,grtr_ann)
  %RUN Summary of this function goes here
  %   Detailed explanation goes here
  
  detected = true;
  
  if obj.rotation
    % if rotation flag is on
    p = obj.Ann2SRT(grtr_ann);
    ann = sm.P2Ann(p);
  else
    % if not
    p = obj.Ann2ST(grtr_ann);
    ann = sm.P2Ann(p);
  end

end

