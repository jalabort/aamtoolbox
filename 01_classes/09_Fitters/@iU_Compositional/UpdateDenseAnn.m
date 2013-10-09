function [ann,p] = UpdateDenseAnn(obj,i,ann,delta,p)
  %UpdateDenseAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  [ann,p] = obj.w{i}.UpdateDenseAnn(obj.sm{i},ann,delta,p);

end

