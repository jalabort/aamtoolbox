function [x,y] = Shape2XY(obj,shapes)
  %SHAPE2XY Summary of this function goes here
  %   Detailed explanation goes here

  ann = obj.Shape2Ann(shapes);
  
  x = squeeze(ann(:,1,:));
  y = squeeze(ann(:,2,:));
  
end
