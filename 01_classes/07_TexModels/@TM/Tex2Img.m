function [img] = Tex2Img(obj,tex)
  %Tex2Img Summary of this function goes here
  %   Detailed explanation goes here

  n_tex = size(tex,2);
  img = zeros([obj.res,obj.n_ch,n_tex]);
  aux = zeros(obj.res);
  
  for i = 1:n_tex
    for j = 1:obj.n_ch
      aux(obj.mask1) = obj.GetTexCh(tex(:,i),j);
      img(:,:,j,i) = aux;
    end
  end
  
end