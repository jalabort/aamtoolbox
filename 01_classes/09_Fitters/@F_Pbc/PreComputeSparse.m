function [obj] = PreComputeSparse(obj,i)
  %PreComputeSparse Summary of this function goes here
  %   Detailed explanation goes here
  
  obj.t{i} = obj.tm{i}.GetMean();
  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(obj.t{i});

  dWduvi = obj.w{i}.Compute_dWduvi();
  obj.dWdp{i} = obj.sm{i}.Compute_dWdp(dWduvi);
  
  Jt = obj.tm{i}.Compute_dtdp(dtdx,dtdy,obj.dWdp{i});
  obj.Jt{i} = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(Jt));
  
end

