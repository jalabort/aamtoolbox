function [img] = ProjectImg(obj,img)
  %ProjectImg Summary of this function goes here
  %   Detailed explanation goes here

  img = obj.C2Img(obj.Img2C(img));

end

