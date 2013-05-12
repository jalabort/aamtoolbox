function [wxy,xy] = Compute_Wxy(obj,ann,res)
%Compute_Wxy Summary of this function goes here
%   Detailed explanation goes here

  xy = obj.rf.xy;

  U = obj.GetWeights(ann);
  wxy = obj.k * U;
  
 list = wxy(:,1) > 0 & ...
        wxy(:,1)<= res(2) & ...
        wxy(:,2) > 0 & ...
        wxy(:,2)<= res(1);
      
  wxy = wxy(list,:);
  xy = xy(list,2) + (xy(list,1) - 1) * obj.rf.res(1);
  
end

