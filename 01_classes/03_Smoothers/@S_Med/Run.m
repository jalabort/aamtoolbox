function [img] = Run(obj,img)
  %Run Summary of this function goes here
  %   Detailed explanation goes here
  
  if size(img,3) == 3
    img = rgb2gray(img);
  end
  
  img = medfilt2(img,obj.K);

end

