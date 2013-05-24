function [obj] = PreCompute(obj,i)
  %PreCompute Summary of this function goes here
  %   Detailed explanation goes here
  
  t = obj.tm{i}.GetMean();
  
  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(t);
  
  obj.t{i} = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(t));

  dWduvi = obj.w{i}.Compute_dWduvi();
  dWduvi = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(dWduvi,1),1);
  
  dWdp = obj.sm{i}.Compute_dWdp(dWduvi);
  
  obj.J{i} = obj.tm{i}.Compute_dtdp(dtdx,dtdy,dWdp);
  
end

