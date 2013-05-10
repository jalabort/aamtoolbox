function [simg] = Run(obj,img)
  %RUN Summary of this function goes here
  %   Detailed explanation goes here
  
  simg = imfilter(img,obj.H,'replicate');

end

