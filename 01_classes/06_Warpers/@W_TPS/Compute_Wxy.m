function [wxy,xy] = Compute_Wxy(obj,ann,res)
%Compute_Wxy Summary of this function goes here
%   Detailed explanation goes here

  max_ind_img = res(1) * res(2);

  xy = obj.rf.xy;

  U = obj.GetWeights(ann);
  wxy = obj.k * U;
  
  list = wxy > 0 & wxy <= max_ind_img;
  wxy = wxy(list);
  xy = xy(list);

end

