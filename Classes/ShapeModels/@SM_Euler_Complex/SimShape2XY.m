function [x,y] = SimShape2XY(obj,sShapes)
  %SIMSHAPE2XY Summary of this function goes here
  %   Detailed explanation goes here

  ann = obj.SimShape2Ann(sShapes);
  
  x = squeeze(ann(:,1,:));
  y = squeeze(ann(:,2,:));
  
end
