function [obj,loaded] = Load(opt)
  %LOAD Summary of this function goes here
  %   Detailed explanation goes here

  opt_str = [opt.name                     '_' ...
            int2str(opt.n_level)          '_' ...
            int2str(cell2mat(opt.factor)) '_' ...
            int2str(opt.erode)            '_' ...
            opt.warp                      '_' ...
            opt.smoothing                 '_' ...
            opt.g_type                    '_' ...  
            int2str(cell2mat(opt.sigma))  '_' ...
            cell2mat(opt.shape_model)     '_' ...
            opt.tex_model];
          
  hash_code = DataHash(opt.train_reg_exp_query);
  file_name = [opt_str '_' hash_code '.mat'];
  
  if exist([opt.model_root file_name],'file')
    load([opt.model_root file_name], 'obj');
    loaded = true;
  else
    obj = [];
    loaded = false;
  end
  
end
