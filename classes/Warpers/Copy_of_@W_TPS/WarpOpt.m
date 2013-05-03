function [warpedImg] = WarpOpt(obj,ann,img,~)
  %WARPOPT Summary of this function goes here
  %   Detailed explanation goes here
  
  switch size(img,3)
    case 1
      [warpedImg] = obj.Warp1ChOpt(ann,img);
    case 2
      [warpedImg] = obj.Warp2ChOpt(ann,img);
    case 3
      [warpedImg] = obj.Warp3ChOpt(ann,img);
  end

end

