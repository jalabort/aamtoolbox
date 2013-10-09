function [wimg] = WarpDense(obj,ann,img)
  %WarpDense Summary of this function goes here
  %   Detailed explanation goes here

  n_ch = size(img,3);
  wimg = zeros([obj.rf.res,n_ch]);

  for i = 1:n_ch
    aux = zeros(obj.rf.res);
    c = ba_interp2(img(:,:,i), ...
      ann(obj.rf.n_vert+1:end,1),ann(obj.rf.n_vert+1:end,2),obj.interp);
    aux(obj.rf.mask1) = c; 
    wimg(:,:,i) = max(min(aux,1),0);
  end

end

