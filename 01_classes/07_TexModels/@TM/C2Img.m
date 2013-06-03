function [img] = C2Img(obj,c)
  %C2Img Summary of this function goes here
  %   Detailed explanation goes here

  img = obj.Tex2Img(obj.C2Tex(c));

end

