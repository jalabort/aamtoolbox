function [tex] = Transform(obj,img)
  %TrandformCh Summary of this function goes here
  %   Detailed explanation goes here
  
  tex = obj.Img2Tex(img);
  tex = tex - mean(tex);
  tex = tex ./ std(tex);
  
  tex(isnan(tex)) = 0;
  tex(isinf(tex)) = 0;
  
end

