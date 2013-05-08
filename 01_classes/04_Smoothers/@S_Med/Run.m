function [sImg] = Run(obj,img)
  %RUN Summary of this function goes here
  %   Detailed explanation goes here
  
  sImg = medfilt2(img,obj.K);

end

