function [img] = CroppedTex2Img(obj,ctex,n_ch)
  %CroppedTex2Img Summary of this function goes here
  %   Detailed explanation goes here

  if nargin < 3
    n_ch = obj.n_ch;
  end
  
  n_tex = size(ctex,2);
  img = zeros([obj.res,n_ch,n_tex]);
  aux = zeros(obj.res);
  
  for i = 1:n_tex
    for j = 1:n_ch
      aux(obj.mask2) = obj.GetCroppedTexCh(ctex(:,i),j);
      img(:,:,j,i) = aux;
    end
  end
  
end