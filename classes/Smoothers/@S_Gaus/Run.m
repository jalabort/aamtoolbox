function [sImg] = Run(obj,img)
  %RUN Summary of this function goes here
  %   Detailed explanation goes here
  
  sImg = imfilter(img,obj.H,'replicate');

end

