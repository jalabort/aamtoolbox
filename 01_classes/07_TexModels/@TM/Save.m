function Save(obj,opt,i)
  %SAVE Summary of this function goes here
  %   Detailed explanation goes here
  
  n_level = length(opt.level);
  
  if n_level == length(opt.erode1)
    erode1 = opt.erode1{i}; 
  else
    erode1 = cell2mat(opt.erode1); 
  end
  if n_level == length(opt.erode2)
    erode2 = opt.erode2{i};
  else
    erode2 = cell2mat(opt.erode2);
  end
  if n_level == length(opt.interp)
    interp = opt.interp{i};
  else
    interp = cell2mat(opt.interp);
  end
  if n_level == length(opt.warp)
    warp_type = opt.warp{i};
  else
    warp_type = cell2mat(opt.warp);
  end
  if n_level == length(opt.shape_model)
    smoother_type = opt.smoother{i};
  else
    smoother_type = cell2mat(opt.smoother);
  end
  if n_level == length(opt.sigma)
    sigma = opt.sigma{i};
  else
    sigma = cell2mat(opt.sigma);
  end
  if n_level == length(opt.tex_model)
    tex_model_type = opt.tex_model{i};
  else
    tex_model_type = cell2mat(opt.tex_model);
  end

  opt_str = [opt.name '_' ...
             opt.ann '_' ...
             mat2str(opt.level{i}) '_' ...
             mat2str(erode1) '_' ...
             mat2str(erode2) '_' ...
             mat2str(interp) '_' ...
             mat2str(warp_type) '_' ...
             mat2str(smoother_type) '_' ...
             mat2str(sigma) '_' ...
             mat2str(tex_model_type)];
          
  hash_code = DataHash(opt.reg_exp_query);
  file_name = [opt_str '_' hash_code '.mat'];
  
  save([opt.root 'texmodel' filesep file_name],'obj','-v7.3');

end