function [ann,p] = UpdateAnn(obj,i,ann,delta,p)
  %UpdateAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  [ann,p] = obj.w{i}.UpdateAnn(obj.sm{i},ann,delta,p);

end

