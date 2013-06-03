function [c] = Img2C(obj,img)
  %Img2 Summary of this function goes here
  %   Detailed explanation goes here

  c = obj.Tex2C(obj.Img2Tex(img));

end

