function [cann] = Compute_WoW(obj,mu_ann,pann,ann)
  %Compute_WoW Summary of this function goes here
  %   Detailed explanation goes here

  if exist('dWodW.mexa64','file')
    cann = WoW(mu_ann,pann,ann,obj.c_i_vert,obj.c_n_vert,obj.c_sorted_tri,obj.c_n_sorted_tri,obj.c_i_tri,obj.c_tri,obj.c_n_tri,obj.c_n_vert);
  else
    cann = obj.WoW(mu_ann,pann,ann);
  end

end

