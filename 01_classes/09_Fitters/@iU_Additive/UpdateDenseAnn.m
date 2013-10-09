function [ann,p] = UpdateDenseAnn(obj,i,~,delta,p)
  %UpdateDenseAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  p = p + delta;
  ann = obj.sm{i}.P2Ann(p);
 
end

