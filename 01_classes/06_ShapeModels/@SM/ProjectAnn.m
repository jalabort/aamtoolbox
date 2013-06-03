function [ann,p] = ProjectAnn(obj,ann)
  %ProjectAnn Summary of this function goes here
  %   Detailed explanation goes here

  p = obj.Ann2P(ann);
  ann = obj.P2Ann(p);

end

