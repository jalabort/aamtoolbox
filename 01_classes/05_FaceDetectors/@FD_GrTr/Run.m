function [ann,detected,q] = Run(~,sm,~,grtr_ann)
  %RUN Summary of this function goes here
  %   Detailed explanation goes here
  
  detected = true;
  ref_shape = sm.Ann2Shape(grtr_ann);
  q = sm.Shape2Q(ref_shape);
  q = sm.KillRotations(q);
  ann = sm.Shape2Ann(sm.Q2Shape(q));

end

