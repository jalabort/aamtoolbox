function [obj,loaded] = Load(opt,i)
  %LOAD Summary of this function goes here
  %   Detailed explanation goes here
  
  n_level = length(opt.level);
  
  if n_level == length(opt.shape_model)
    shape_model_type = opt.shape_model{i};
  else
    shape_model_type = cell2mat(opt.shape_model);
  end
  if n_level == length(opt.alpha)
    alpha = opt.alpha{i};
  else
    alpha = cell2mat(opt.alpha);
  end

  opt_str = [opt.name '_' ...
             opt.ann '_' ...
             mat2str(opt.level{i}) '_' ...
             shape_model_type '_' ...
             int2str(opt.dense) '_' ...
             mat2str(alpha)];
           
  hash_code = DataHash(opt.reg_exp_query);
  file_name = [opt_str '_' hash_code '.mat'];
  
  if exist([opt.root 'shapemodel' filesep file_name],'file')
    load([opt.root 'shapemodel' filesep file_name], 'obj');
    loaded = true;
  else
    obj = [];
    loaded = false;
  end
  
end
