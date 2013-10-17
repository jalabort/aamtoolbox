function [obj,loaded] = Load(opt)
  %LOAD Summary of this function goes here
  %   Detailed explanation goes here

  opt_str = [opt.name '_' ...
             opt.ann '_' ...
             opt.shape_model '_' ...
             int2str(opt.dense) '_' ...
             mat2str(opt.shape_lp) '_' ...
             mat2str(opt.shape_alpha) '_' ...
             int2str(opt.erode1) '_' ...
             int2str(opt.erode2) '_' ...
             opt.warp '_' ...
             opt.interp '_' ...
             mat2str(cell2mat(opt.level)) '_' ...
             cell2mat(opt.smoother) '_' ...  
             mat2str(cell2mat(opt.sigma)) '_' ...
             cell2mat(opt.feature) '_' ...
             cell2mat(opt.tex_model) '_' ...
             mat2str(cell2mat(opt.tex_lp)) '_' ...
             mat2str(cell2mat(opt.tex_alpha))];
           
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
