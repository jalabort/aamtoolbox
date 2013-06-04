function [ann,p] = UpdateSparseAnn(obj,i,ann,delta,p)
  %UpdateSparseAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  [ann,p] = obj.w{i}.UpdateSparseAnn(obj.sm{i},ann,delta,p);

end

