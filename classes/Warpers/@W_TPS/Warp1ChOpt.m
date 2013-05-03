function [wimg] = Warp1ChOpt(obj,ann,img)
  %WARP1CHOPT Summary of this function goes here
  %   Detailed explanation goes here

  wimg = zeros(obj.rf.res);
  
  W = obj.GetWeights(ann);
  wpos = obj.k*W;

  aux = ba_interp2(img,wpos(:,1),wpos(:,2),obj.interp);
  wimg(obj.rf.mask2) = aux; 

end

