function [img] = CroppedTex2Img2(obj,ctex)
  %CroppedTex2Img2 Summary of this function goes here
  %   Detailed explanation goes here

  n_tex = size(ctex,2);
  img = zeros([obj.res,obj.n_ch,n_tex]);
  aux = zeros(obj.res);
  
  for i = 1:n_tex
    for j = 1:obj.n_ch
      aux(obj.mask2) = obj.GetCroppedTexCh(ctex(:,i),j);
      img(:,:,j,i) = aux;
    end
  end
  
end