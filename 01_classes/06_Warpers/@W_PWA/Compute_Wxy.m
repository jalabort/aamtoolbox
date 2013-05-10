function [wxy,xy] = Compute_Wxy(obj,ann,res)
  %COMPUTE_WXY Summary of this function goes here
  %   Detailed explanation goes here
  
  if exist('Wxy.mexa64','file')
    [wxy,xy] = Wxy(obj.rf.res,obj.c_i_base,img,img_res,obj.c_tri,obj.c_n_tri,obj.c_pixel_tri,ann(:,1),ann(:,2),obj.c_alphas,obj.c_betas,obj.c_gammas,obj.c_n_warped_pixels);
  else
    [wxy,xy] = obj.Wxy(ann,res);
  end

end

