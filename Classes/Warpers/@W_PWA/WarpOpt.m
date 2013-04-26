function [wimg] = WarpOpt(obj,ann,img,img_res)
  %WARPOPT Summary of this function goes here
  %   Detailed explanation goes here
  
  switch size(img,3)
    case 1
      [wimg] = obj.Warp1ChOpt(ann,img,img_res);
    case 3
      [wimg] = obj.Warp3ChOpt(ann,img,img_res);
  end

end

