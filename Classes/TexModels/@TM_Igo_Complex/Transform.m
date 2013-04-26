function [igoTex] = Transform(obj,aliImg,nCh)
  %TRANSFORM Summary of this function goes here
  %   Detailed explanation goes here
  
  fnG = zeros(obj.nFacePixels*nCh,1);
  
  for ch = 1:nCh
    sImg = obj.smoother.Run(aliImg(:,:,ch));
    [~,Gdir] = imgradient(sImg);
    auxX = cosd(Gdir);
    auxY = sind(Gdir);
    fnG(1+obj.nFacePixels*(ch-1):obj.nFacePixels*ch) = auxX(obj.mask) + 1i*auxY(obj.mask);
  end
  
  igoTex = fnG ./ sqrt(obj.nFacePixels);

end

