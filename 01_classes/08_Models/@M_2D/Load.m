function [obj,loaded] = Load(opt)
  %LOAD Summary of this function goes here
  %   Detailed explanation goes here
  
  n_level = length(opt.level);

  opt_str = [opt.name '_' ...
             opt.ann '_' ...
             mat2str(n_level) '_' ...
             mat2str(cell2mat(opt.erode1)) '_' ...
             mat2str(cell2mat(opt.erode2)) '_' ...
             cell2mat(opt.warp) '_' ...
             cell2mat(opt.interp) '_' ...
             cell2mat(opt.smoother) '_' ...  
             mat2str(cell2mat(opt.sigma)) '_' ...
             cell2mat(opt.shape_model) '_' ...
             cell2mat(opt.tex_model) '_' ...
             mat2str(cell2mat(opt.alpha))];
           
  hash_code = DataHash(opt.reg_exp_query);
  file_name = [opt_str '_' hash_code '.mat'];
  
  if exist([opt.root file_name],'file')
    load([opt.root file_name], 'obj');
    loaded = true;
  else
    obj = [];
    loaded = false;
  end
  
end
