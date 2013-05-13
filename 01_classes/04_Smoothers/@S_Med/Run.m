function [simg] = Run(obj,img)
  %Run Summary of this function goes here
  %   Detailed explanation goes here
  
  simg = medfilt2(img,obj.K);

end

