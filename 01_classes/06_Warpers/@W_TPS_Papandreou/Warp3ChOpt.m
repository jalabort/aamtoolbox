function [wimg] = Warp3ChOpt(obj,ann,img)
  %WARP3CHOPT Summary of this function goes here
  %   Detailed explanation goes here

  wimg = zeros([obj.rf.res 3]);
  wimg1 = zeros(obj.rf.res);
  wimg2 = wimg1;
  wimg3 = wimg1;
  
  W = obj.GetWeights(ann);
  wpos = obj.k * W;

  aux1 = ba_interp2(img(:,:,1),wpos(:,1),wpos(:,2),obj.interp);
  aux2 = ba_interp2(img(:,:,2),wpos(:,1),wpos(:,2),obj.interp);
  aux3 = ba_interp2(img(:,:,3),wpos(:,1),wpos(:,2),obj.interp);
  
  wimg1(obj.rf.mask2) = aux1; 
  wimg2(obj.rf.mask2) = aux2;
  wimg3(obj.rf.mask2) = aux3;
  
  wimg(:,:,1) = wimg1;
  wimg(:,:,2) = wimg2;
  wimg(:,:,3) = wimg3;

end

