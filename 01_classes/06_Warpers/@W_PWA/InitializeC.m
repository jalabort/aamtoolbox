function [obj] = InitializeC(obj)
  %INITIALIZEC Summary of this function goes here
  %   Detailed explanation goes here
  
  for i = 1:obj.n_tri
    obj.c_pixel_tri = [obj.c_pixel_tri;i*ones(size(obj.v{i}))];
    obj.c_i_base = [obj.c_i_base;obj.ind_base{i}];
    obj.c_alphas = [obj.c_alphas;obj.alphas{i}];
    obj.c_betas = [obj.c_betas;obj.betas{i}];
    obj.c_gammas = [obj.c_gammas;obj.gammas{i}];
  end

  for i = 1:obj.rf.n_vert
    obj.c_i_vert = [obj.c_i_vert;i*ones(size(obj.sorted_tri{i}))];
    obj.c_sorted_tri = [obj.c_sorted_tri;obj.sorted_tri{i}];
    obj.c_i_tri = [obj.c_i_tri;sum(obj.c_n_sorted_tri)];
    obj.c_n_sorted_tri = [obj.c_n_sorted_tri;length(obj.sorted_tri{i})];
  end

  obj.c_i_tri = [obj.c_i_tri;sum(obj.c_n_sorted_tri)];

  obj.c_n_vert = obj.rf.n_vert;
  obj.c_tri = obj.tri;
  obj.c_n_tri = obj.n_tri;
  
  c_n_warped_pixels = length(obj.c_i_base);
  c_n_composed_vert = obj.rf.n_vert;
  obj.c_n_warped_pixels = c_n_warped_pixels;
  obj.c_n_composed_vert = c_n_composed_vert;

end

