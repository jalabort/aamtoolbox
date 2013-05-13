function [cann] = Compose_dWodW(obj,mu_ann,qpr_ann,ann)
  %COMPOSE_DWODW Summary of this function goes here
  %   Detailed explanation goes here

  if exist('dWodW.mexa64','file')
    cann = dWodW(mu_ann,qpr_ann,ann,obj.c_i_vert,obj.c_n_vert,obj.c_sorted_tri,obj.c_n_sorted_tri,obj.c_i_tri,obj.c_tri,obj.c_n_tri,obj.c_n_vert);
  else
    cann = obj.dWodW(mu_ann,qpr_ann,ann);
  end

end

