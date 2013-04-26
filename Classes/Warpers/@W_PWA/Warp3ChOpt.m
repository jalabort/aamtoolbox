function [wimg] = Warp3ChOpt(obj,ann,img,img_res)
  %WARP1CHOPT Summary of this function goes here
  %   Detailed explanation goes here

  if exist('Warp3ChOptC.mexa64','file')
    wimg = Warp3ChOptC(obj.rf.res,obj.c_i_base,img,img_res,obj.c_tri,obj.c_n_tri,obj.c_pixel_tri,ann(:,1),ann(:,2),obj.c_alphas,obj.c_betas,obj.c_gammas,obj.c_n_warped_pixels);
  else
    [wimg] = Warp3ChOptM(obj,ann,img,img_res);
  end
    
end

