function [ann] = ProjectAnn(obj,ann)
  %ProjectAnn Summary of this function goes here
  %   Detailed explanation goes here

  ann = obj.P2Ann(obj.Ann2P(ann));

end

