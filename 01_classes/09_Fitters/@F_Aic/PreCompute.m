function [obj] = PreCompute(obj,i)
  %PreCompute Summary of this function goes here
  %   Detailed explanation goes here

  dWduvi = obj.w{i}.Compute_dWduvi();
  dWduvi = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(dWduvi,1),1);
  
  obj.dWdp{i} = obj.sm{i}.Compute_dWdp(dWduvi);
  
end

