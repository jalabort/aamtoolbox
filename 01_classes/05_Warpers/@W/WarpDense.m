function [wimg] = WarpDense(obj,ann,img)
  %WarpDense Summary of this function goes here
  %   Detailed explanation goes here

  wimg = zeros([obj.rf.res,n_ch]);

  for i = 1:n_ch
    aux = zeros(obj.rf.res);
    c = ba_interp2(img(:,:,i),ann(:,1),ann(:,2),obj.interp);
    aux(uv_vec) = c; 
    wimg(:,:,i) = max(min(aux,1),0);
  end

end

