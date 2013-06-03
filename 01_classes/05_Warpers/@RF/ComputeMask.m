function mask = ComputeMask(obj,contour,erode)
  %ComputeMask Summary of this function goes here
  %   Detailed explanation goes here
  
  xy = obj.tc(contour,:);
  x = xy(:,1);
  y = xy(:,2);
  mask = zeros(obj.res);
  mask = roipoly(mask,x,y);
  mask = imerode(mask>0,strel('disk',erode));
  
end


