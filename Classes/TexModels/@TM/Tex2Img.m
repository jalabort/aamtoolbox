function [img] = Tex2Img(obj,tex)
  %TEX2IMG Summary of this function goes here
  %   Detailed explanation goes here

  n_tex = size(tex,2);
  img = zeros(obj.res(1),obj.res(2),obj.n_ch,n_tex);
  aux = zeros(obj.res(1),obj.res(2));
  
  for i = 1:n_tex
    for j = 1:obj.n_ch
      aux(obj.mask) = obj.getTexCh(tex(:,i),j);
      img(:,:,j,i) = aux;
    end
  end
  
end