function [obj] = PreCompute(obj,i)
  %PreCompute Summary of this function goes here
  %   Detailed explanation goes here
  
  t = obj.tm{i}.GetMean();
  obj.t{i} = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(t));

  dWduvi = obj.w{i}.Compute_dWduvi();
  obj.dWduvi{i} = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(dWduvi,1),1);
  
end

