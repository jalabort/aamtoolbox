function [obj,loaded] = Load(opt,i)
  %LOAD Summary of this function goes here
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
  if n_level == length(opt.tex_model)
    tex_model_type = opt.tex_model{i};
  else
    tex_model_type = cell2mat(opt.tex_model);
  end
  if n_level == length(opt.tex_lp)
    lp = opt.tex_lp{i}; 
  else
    lp = cell2mat(opt.tex_lp); 
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
             int2str(opt.dense) '_' ...
             tex_model_type '_' ...
             num2str(lp) '_' ...
             num2str(alpha)];
           
  hash_code = DataHash(opt.reg_exp_query);
  file_name = [opt_str '_' hash_code '.mat'];
  
  if exist([opt.root 'texmodel' filesep file_name],'file')
    load([opt.root 'texmodel' filesep file_name], 'obj');
    loaded = true;
  else
    obj = [];
    loaded = false;
  end
  
end
