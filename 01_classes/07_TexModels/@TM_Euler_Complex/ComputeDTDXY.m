function [dt_dx,dt_dy] = ComputeDTDXY(obj,t)
%COMPUTEDTDXY Summary of this function goes here
%   Detailed explanation goes here

  img = obj.Tex2Img(t);
  gx = zeros(size(img));
  gy = gx;
  for i = 1:obj.n_ch
    [rgx,rgy] = imgradientxy(real(img(:,:,i)));
    [igx,igy] = imgradientxy(imag(img(:,:,i)));
    gx = rgx + 1i*igx;
    gy = rgy + 1i*igy;
  end
  dt_dx = obj.Img2Tex(gx);
  dt_dy = obj.Img2Tex(gy);
  
end

