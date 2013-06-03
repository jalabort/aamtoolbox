function [img] = Run(obj,img)
  %Run Summary of this function goes here
  %   Detailed explanation goes here
  
  img = imfilter(img,obj.H,'replicate');

end

