display('- loading model');

% load model
[m,loaded] = M_2D.Load(opt.m);

if ~loaded
  
  display('- model not found');
  display('- building model');
  display(' - loading training dataset');
  
  % load training dataset
  [train_ds,loaded] = train_db.Load(opt.m.reg_exp_query);
  assert(loaded,'training set could not be loaded!'); 
  
  n_level = length(opt.m.level);
  sm =  cell(n_level,1);
  w =  cell(n_level,1);
  tm =  cell(n_level,1);
  smoother = cell(n_level,1);

  if opt.m.dense
    Build_MDense_From_DS;
  else
    Build_MSparse_From_DS;
  end

  % clear some memory
  clear loaded train_ds factor ann shape_model_type ref_ann parts ...
  erode1 erode2 rf smoother_type sm_ sigma tri interp lp feature_type ...
  warp_type  img tex_model_type n_level i

  % build model
  m = M_2D(sm,w,tm,smoother);
  clear w sm tm smoother

  % save model
  m.Save(opt.m);

  display('- model saved');  
  
end