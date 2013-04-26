function mask = ComputeMask2(obj,contour)
  %COMPUTEMASK Summary of this function goes here
  %   Detailed explanation goes here
  
  xy = obj.tc(contour,:);
  x = xy(:,1);
  y = xy(:,2);
  mask = zeros(obj.res);
  mask = roipoly(mask,x,y);
  mask = mask>0;
  
end


