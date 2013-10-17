function Save(obj,opt)
  %SAVE Summary of this function goes here
  %   Detailed explanation goes here
  
  opt_str = [opt.name '_' ...
             opt.ann '_' ...
             opt.shape_model '_' ...
             int2str(opt.dense) '_' ...
             opt.warp '_' ...
             num2str(opt.shape_alpha)];    
          
  hash_code = DataHash(opt.reg_exp_query);
  file_name = [opt_str '_' hash_code '.mat'];
  
  save([opt.root 'shapemodel' filesep file_name],'obj','-v7.3');

end