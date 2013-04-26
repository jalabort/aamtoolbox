function [warpedImg] = Warp1ChOpt(obj,ann,img)
  %WARP1CHOPT Summary of this function goes here
  %   Detailed explanation goes here

  warpedImg = zeros(obj.refFrame.res);
  
  r = zeros(obj.refFrame.nFacePixels2,obj.refFrame.nVert);
  
  for v = 1:obj.refFrame.nVert
    r(:,v) = sqrt(sum((obj.pos - repmat(obj.refFrame.tc(v,:),[obj.refFrame.nFacePixels2,1])).^2,2));
  end
  
  k = [r.^2 .* log(r.^2),ones(obj.refFrame.nFacePixels2,1),obj.pos(:,1),obj.pos(:,2)];
  W = obj.GetWeights(ann);
  
  warpedPos = k*W;

  aux = interp2(img,warpedPos(:,1),warpedPos(:,2),obj.interp);
  warpedImg(obj.refFrame.mask2) = aux; 

end

