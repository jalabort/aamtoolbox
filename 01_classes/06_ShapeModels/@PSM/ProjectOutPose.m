function ann = ProjectOutPose(obj,ann)
  %ProjectOutPose Summary of this function goes here
  %   Detailed explanation goes here
  
  shape = obj.Ann2Shape(ann);
  shape = shape - obj.L2Shape(obj.Shape2L(shape)) + repmat(obj.pose_mu,[1,size(shape,2)]);
  ann = obj.Shape2Ann(shape);
end

