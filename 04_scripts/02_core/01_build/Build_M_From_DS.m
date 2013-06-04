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

  w =  cell(n_level,1);
  sm = cell(n_level,1);
  tm =  cell(n_level,1);

  for i = 1:n_level
    if n_level == length(opt.m.dense)
      dense = opt.m.dense{i};
    else
      dense = cell2mat(opt.m.dense);
    end
    if dense
      Build_MDense_From_DS;
    else
      Build_MSparse_From_DS;
    end
  end
  
  % clear some memory
  clear loaded train_ds factor ann shape_model_type ref_ann parts ...
  erode1 erode2 rf smoother_type sigma smoother tri interp ...
  warp_type  img tex_model_type n_level i

  % build model
  m = M_2D(sm,w,tm);
  clear w sm tm

  % save model
  m.Save(opt.m);

  display('- model saved');  
  
end