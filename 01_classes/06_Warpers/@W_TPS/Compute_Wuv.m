function [xy,uv_vec] = Compute_Wuv(obj,ann,res)
  %Compute_Wuv Summary of this function goes here
  %   Detailed explanation goes here

  U = obj.GetWeights(ann);
  xy = obj.k * U;
  
 list = xy(:,1) > 0 & ...
        xy(:,1)<= res(2) & ...
        xy(:,2) > 0 & ...
        xy(:,2)<= res(1);
      
  xy = xy(list,:);
  uv_vec = obj.rf.uv_vec(list);
  
end

