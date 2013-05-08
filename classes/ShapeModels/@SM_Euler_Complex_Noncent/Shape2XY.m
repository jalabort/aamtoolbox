function [x,y] = Shape2XY(obj,eShapes)
  %SHAPE2XY Summary of this function goes here
  %   Detailed explanation goes here

  ann = obj.EulerShape2Ann(eShapes);
  
  x = squeeze(ann(:,1,:));
  y = squeeze(ann(:,2,:));
  
end
