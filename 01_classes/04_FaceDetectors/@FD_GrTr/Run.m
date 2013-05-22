function [ann,detected,p] = Run(obj,sm,~,grtr_ann)
  %Run Summary of this function goes here
  %   Detailed explanation goes here
  
  detected = true;
  
  if obj.rotation
    % if rotation flag is on
    p = sm.Ann2SRT(grtr_ann);
  else
    % if not
    p = sm.Ann2ST(grtr_ann);
  end
  
  ann = sm.P2Ann(p);

end

