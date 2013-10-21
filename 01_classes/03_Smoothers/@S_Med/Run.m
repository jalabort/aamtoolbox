function [img] = Run(obj,img)
  %Run Summary of this function goes here
  %   Detailed explanation goes here
  
  for i = 1:size(img,3)
    img(:,:,i) = medfilt2(img(:,:,i),obj.K);
  end

end

