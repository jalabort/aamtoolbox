function [dt_dx,dt_dy] = ComputeDTDXY(obj,t)
%COMPUTEDTDXY Summary of this function goes here
%   Detailed explanation goes here

  img = obj.Tex2Img(t);
  gx = zeros(size(img));
  gy = gx;
  for i = 1:obj.n_bin
    [gx(:,:,i),gy(:,:,i)] = imgradientxy(img(:,:,i));
  end
  dt_dx = obj.Img2Tex(gx);
  dt_dy = obj.Img2Tex(gy);
  
end

