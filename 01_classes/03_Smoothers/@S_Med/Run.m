function [img] = Run(obj,img)
  %Run Summary of this function goes here
  %   Detailed explanation goes here
  
  img = medfilt2(img,obj.K);

end

