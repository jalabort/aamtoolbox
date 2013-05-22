function [dtdx,dtdy] = Compute_dtdxy(obj,t)
  %Compute_dtdxy Summary of this function goes here
  %   Detailed explanation goes here

  img = obj.Tex2Img(t);
  gx = zeros(size(img));
  gy = gx;
  for i = 1:obj.n_ch
    [gx(:,:,i),gy(:,:,i)] = gradient(img(:,:,i));
  end
  dtdx = obj.Img2CroppedTex(gx);
  dtdy = obj.Img2CroppedTex(gy);
  
end

