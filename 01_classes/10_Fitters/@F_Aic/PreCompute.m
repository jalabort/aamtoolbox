function [obj] = PreCompute(obj,i)
  %PreComputeE Summary of this function goes here
  %   Detailed explanation goes here

  dw_dxy = obj.w{i}.ComputeDWDXY();
  dw_dxy = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(dw_dxy));
  
  obj.dw_dp{i} = obj.sm{i}.ComputeDWDQPR(dw_dxy);
  
end

