function [wimg] = WarpSparse(obj,ann,img)
  %WarpDense Summary of this function goes here
  %   Detailed explanation goes here

  [res(1),res(2),n_ch] = size(img);
  wimg = zeros([obj.rf.res,n_ch]);
  
  [xy,uv_vec] = obj.Compute_Wuv(ann,res);

  for i = 1:n_ch
    aux = zeros(obj.rf.res);
    c = ba_interp2(img(:,:,i),xy(:,1),xy(:,2),obj.interp);
    aux(uv_vec) = c; 
    wimg(:,:,i) = max(min(aux,1),0);
  end

end

