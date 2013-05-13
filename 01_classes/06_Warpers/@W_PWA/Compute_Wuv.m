function [xy,uv_vec] = Compute_Wuv(obj,ann,res)
  %Compute_Wuv Summary of this function goes here
  %   Detailed explanation goes here
  
  if exist('Wxy.mexa64','file')
    [xy,uv_vec] = Wuv(obj.rf.res,obj.c_i_base,img,img_res,obj.c_tri,obj.c_n_tri,obj.c_pixel_tri,ann(:,1),ann(:,2),obj.c_alphas,obj.c_betas,obj.c_gammas,obj.c_n_warped_pixels);
  else
    [xy,uv_vec] = obj.Wuv(ann,res);
  end

end

