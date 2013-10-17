function Save(img,opt,i)
  %SAVE Summary of this function goes here
  %   Detailed explanation goes here
  
  n_level = length(opt.level);
  
  if n_level > 1 && n_level == length(opt.shape_model)
    smoother_type = opt.smoother{i};
  else
    smoother_type = cell2mat(opt.smoother);
  end
  if n_level > 1 && n_level == length(opt.sigma)
    sigma = opt.sigma{i};
  else
    sigma = cell2mat(opt.sigma);
  end
  if n_level == length(opt.tex_model)
    feature_type = opt.feature{i};
  else
    feature_type = cell2mat(opt.feature);
  end
  if n_level == length(opt.tex_alpha)
    alpha = opt.tex_alpha{i}; 
  else
    alpha = cell2mat(opt.tex_alpha); 
  end
  
  opt_str = [opt.name '_' ...
             opt.ann '_' ...
             int2str(opt.level{i}) '_' ...
             int2str(opt.erode1) '_' ...
             int2str(opt.erode2) '_' ...
             opt.interp '_' ...
             opt.warp '_' ...
             smoother_type '_' ...
             num2str(sigma) '_' ...
             feature_type '_' ...
             int2str(opt.dense)
             num2str(alpha)];
          
  hash_code = DataHash(opt.reg_exp_query);
  file_name = [opt_str '_' hash_code '.mat'];
  
  save([opt.root 'warpedimg' filesep file_name],'img','-v7.3');

end