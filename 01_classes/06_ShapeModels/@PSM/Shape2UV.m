function [u,v] = Shape2UV(obj,shape)
  %Shape2UV Summary of this function goes here
  %   Detailed explanation goes here

  ann = obj.Shape2Ann(shape);
  
  u = squeeze(ann(:,1,:));
  v = squeeze(ann(:,2,:));
  
end
