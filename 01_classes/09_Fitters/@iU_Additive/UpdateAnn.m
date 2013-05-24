function [ann,p] = UpdateAnn(obj,i,~,delta,p)
  %UpdateAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  p = p + delta;
  ann = obj.sm{i}.P2Ann(p);
 
end

