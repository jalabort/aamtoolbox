function [transTexs,nCh] = TransformAll(obj,aliImgs,nImgs,nCh)
  %TRANSFORMALL Summary of this function goes here
  %   Detailed explanation goes here
  
  transTexs = zeros(obj.nFacePixels*nCh,nImgs);
  
  for i = 1:nImgs
    transTexs(:,i) = obj.Transform(aliImgs(:,:,:,i),nCh);
  end

end
