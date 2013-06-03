function [obj] = PreCompute(obj,i)
  %PreCompute Summary of this function goes here
  %   Detailed explanation goes here
  
  t = obj.tm{i}.GetMean();
  obj.t{i} = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(t));

  obj.dWduvi{i} = obj.w{i}.Compute_dWduvi();
  
end

