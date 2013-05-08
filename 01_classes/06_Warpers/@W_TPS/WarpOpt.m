function [wimg] = WarpOpt(obj,ann,img,~)
  %WARPOPT Summary of this function goes here
  %   Detailed explanation goes here
  
  switch size(img,3)
    case 1
      [wimg] = obj.Warp1ChOpt(ann,img);
    case 2
      [wimg] = obj.Warp2ChOpt(ann,img);
    case 3
      [wimg] = obj.Warp3ChOpt(ann,img);
  end

end

