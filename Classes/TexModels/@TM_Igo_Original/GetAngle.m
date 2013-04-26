function [Gdir] = GetAngle(obj,igoTex)
  %GETANGLE Summary of this function goes here
  %   Detailed explanation goes here

  for ch = 1:2:obj.nCh
    auxX = obj.getTexCh(igoTex,ch);
    auxY = obj.getTexCh(igoTex,ch+1);
    Gdir = atan2d(auxY,auxX);
  end

end

