function [img] = Tex2Img2(obj,tex)
  %TEX2IMG2 Summary of this function goes here
  %   Detailed explanation goes here

  n_tex = size(tex,2);
  img = zeros(obj.res(1),obj.res(2),obj.n_ch,n_tex);
  aux = zeros(obj.res(1),obj.res(2));
  
  for i = 1:n_tex
    for j = 1:obj.n_ch
      aux(obj.mask2) = obj.getTexCh2(tex(:,i),j);
      img(:,:,j,i) = aux;
    end
  end
  
end