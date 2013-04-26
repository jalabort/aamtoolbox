function [wimg] = Warp(obj,ann,img,img_res)
  %WARP Summary of this function goes here
  %   Detailed explanation goes here
  
  switch size(img,3)
    case 1
      [wimg] = obj.Warp1Ch(ann,img,img_res);
    case 3
      [wimg] = obj.Warp3Ch(ann,img,img_res);
  end

end

