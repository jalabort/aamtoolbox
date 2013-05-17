function [simg] = Run(obj,img)
  %Run Summary of this function goes here
  %   Detailed explanation goes here
  
  simg = imfilter(img,obj.H,'replicate');

end

