function [cann] = ComposeWarp(obj,mu_ann,qpr_ann,ann)
  %COMPOSEWARP Summary of this function goes here
  %   Detailed explanation goes here

  if exist('ComposePWAWarp.mexa64','file')
    cann = ComposePWAWarp(mu_ann,qpr_ann,ann,obj.c_i_vert,obj.c_n_vert,obj.c_sorted_tri,obj.c_n_sorted_tri,obj.c_i_tri,obj.c_tri,obj.c_n_tri,obj.c_n_vert);
  else
    cann = ComposeWarpM(obj,mu_ann,qpr_ann,ann);
  end

end

