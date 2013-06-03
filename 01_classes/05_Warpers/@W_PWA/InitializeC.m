function [obj] = InitializeC(obj)
%InitializeC Summary of this function goes here
%   Detailed explanation goes here

  obj.c_alphas = cell2mat(obj.alphas');
  obj.c_betas = cell2mat(obj.betas');
  obj.c_gammas = cell2mat(obj.gammas');
  obj.c_uv = cell2mat(obj.uv_vec_triangle');
  
  obj.c_n_uv_triangle(1) = 0;
  for i = 1:obj.n_tri
  	obj.c_n_uv_triangle(i+1) = obj.c_n_uv_triangle(i) + length(obj.v{i});
  end

end

