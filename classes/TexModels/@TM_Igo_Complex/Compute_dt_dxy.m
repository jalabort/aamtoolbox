function [dt_dx,dt_dy] = Compute_dt_dxy(obj,t)
%COMPUTE_DT_DXY Summary of this function goes here
%   Detailed explanation goes here

  img = obj.Tex2Img(t);
  gx = zeros(size(img));
  gy = gx;
  for ch = 1:obj.nCh
    [rgx,rgy] = imgradientxy(real(img(:,:,ch)));
    [igx,igy] = imgradientxy(imag(img(:,:,ch)));
    gx = rgx + 1i*igx;
    gy = rgy + 1i*igy;
  end
  dt_dx = obj.Img2Tex(gx);
  dt_dy = obj.Img2Tex(gy);
  
end

