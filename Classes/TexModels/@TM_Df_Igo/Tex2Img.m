function [img] = Tex2Img(obj,tex)
  %TEX2IMG Summary of this function goes here
  %   Detailed explanation goes here

  img = zeros(obj.res(1),obj.res(2),obj.n_bin);
  aux = zeros(obj.res(1),obj.res(2));
  
  for i = 1:obj.n_bin
    aux(obj.mask) = obj.getTexCh(tex,i);
    img(:,:,i) = aux;
  end
  
end