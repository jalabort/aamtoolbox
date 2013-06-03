function [obj] = PreCompute(obj,i)
  %PreCompute Summary of this function goes here
  %   Detailed explanation goes here
  
  dWduvi = obj.w{i}.Compute_dWduvi();
  dWduvi = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(dWduvi,1),1);
  
  dWdp = obj.sm{i}.Compute_dWdp(dWduvi);
  
  for j = 1:obj.tm{i}.n_c
    [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(obj.tm{i}.pc(:,j));
    obj.J{i}(:,:,j) = obj.tm{i}.Compute_dtdp(dtdx,dtdy,dWdp);
    obj.J{i}(:,:,j) = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(obj.J{i}(:,:,j)));
  end
    
end

