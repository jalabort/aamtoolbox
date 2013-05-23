function [obj] = PreCompute(obj,i)
  %PRECOMPUTE Summary of this function goes here
  %   Detailed explanation goes here
  
  t = obj.tm{i}.GetMean();
  obj.t{i} = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(t));

  dWduvi = obj.w{i}.Compute_dWduvi();
  dWduvi = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(dWduvi,1),1);
  
  obj.dWdp{i} = obj.sm{i}.Compute_dWdp(dWduvi);
  
  obj.A{i} = 1 / obj.tm{i}.variance * ...
    (eye(obj.tm{i}.n_face_features2) - ...
    obj.tm{i}.cropped_pc(:,1:obj.tm{i}.n_c) * ...
    obj.tm{i}.cropped_pc(:,1:obj.tm{i}.n_c)');
end

