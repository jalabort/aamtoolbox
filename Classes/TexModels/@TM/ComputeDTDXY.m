function [dt_dx,dt_dy] = ComputeDTDXY(obj,t)
%COMPUTEDTDXY Summary of this function goes here
%   Detailed explanation goes here

  img = obj.Tex2Img2(t);
  gx = zeros(size(img));
  gy = gx;
  for i = 1:obj.n_ch
    [gx(:,:,i),gy(:,:,i)] = gradient(img(:,:,i));
  end
  dt_dx = obj.Img2Tex(gx);
  dt_dy = obj.Img2Tex(gy);
  
end

