function [wimg] = Warp(obj,ann,img)
%WARP Summary of this function goes here
%   Detailed explanation goes here

  [res(1),res(2),n_ch] = size(img);
  wimg = zeros([obj.rf.res,n_ch]);
  
  [wxy,xy] = obj.Compute_Wxy(ann,res);

  for i = 1:n_ch
    aux = zeros(obj.rf.res);
    c = ba_interp2(img(:,:,i),wxy(:,1),wxy(:,2),obj.interp);
    aux(xy) = c; 
    wimg(:,:,i) = max(min(aux,1),0);
  end

end

