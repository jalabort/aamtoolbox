function [augIgoTex,igoTex] = Coeff2Tex(obj,coeff)
  %COEFF2TEX Summary of this function goes here
  %   Detailed explanation goes here

  igoTex = Coeff2Tex@IgoTexModel(obj,coeff);
  Gdir = obj.GetAngle(igoTex);
  augIgoTex = [cosd(Gdir);sind(Gdir)] ./ sqrt(obj.nFacePixels);

end


