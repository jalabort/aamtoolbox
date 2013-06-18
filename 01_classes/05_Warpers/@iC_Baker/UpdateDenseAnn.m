function [ann,p] = UpdateDenseAnn(~,sm,~,delta,p)
  %UpdateDenseAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  shape = sm.P2Shape(delta);
  shape = sm.ApplyP(p,shape);  
  [shape,p] = sm.ProjectShape(shape);
  ann = sm.Shape2Ann(shape);
  
end

