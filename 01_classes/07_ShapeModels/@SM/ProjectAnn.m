function [pann] = ProjectAnn(obj,ann)
  %ProjectAnn Summary of this function goes here
  %   Detailed explanation goes here

  pann = obj.P2Ann(obj.Ann2P(ann));

end

