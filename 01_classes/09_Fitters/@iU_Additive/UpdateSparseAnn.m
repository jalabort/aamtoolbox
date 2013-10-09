function [ann,p] = UpdateSparseAnn(obj,i,~,delta,p)
  %UpdateSparseAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  p = p + delta;
  ann = obj.sm{i}.P2Ann(p);
 
end

