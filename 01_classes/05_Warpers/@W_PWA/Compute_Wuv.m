function [xy,uv_vec] = Compute_Wuv(obj,ann,res)
  %Compute_Wuv Summary of this function goes here
  %   Detailed explanation goes here
  
  if exist('Wuv.mexw64','file')
    [xy,uv_vec,e] = Wuv(ann(:,1),ann(:,2),res,obj.tri,obj.c_alphas, ...
      obj.c_betas,obj.c_gammas,obj.c_uv, obj.rf.n_face_pixels1, ...
      obj.n_tri,obj.c_n_uv_triangle);
  else
    [xy,uv_vec,e] = obj.Wuv(ann,res);
  end
  
  xy = xy(1:e,:);
  uv_vec = uv_vec(1:e);

end

