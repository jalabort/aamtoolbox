display([' - computing level: ' int2str(i) '/' int2str(n_level)]);

factor = opt.m.level{i};

display ('  - shape model');

% load shape model
[sm{i},loaded] = SM.Load(opt.m,i);

if ~loaded

  % build ...SM... shape model
  ann = factor * train_ds.GetAnn();
  if n_level == length(opt.m.shape_model)
    shape_model_type = opt.m.shape_model{i};
  else
    shape_model_type = cell2mat(opt.m.shape_model);
  end
  if n_level == length(opt.m.alpha)
    alpha = opt.m.alpha{i};
  else
    alpha = cell2mat(opt.m.alpha);
  end
  switch shape_model_type  
    % global shape models
    case 'gsm-real-nwarp'
      sm{i} = GSM_Real_NWarp(ann);
    case 'gsm-real-concat'
      sm{i} = GSM_Real_Concat(ann);
    case 'gsm-euler-real-nwarp'
      sm{i} = GSM_Euler_Real_NWarp(ann,alpha);
    case 'gsm-complex-cent-nwarp'
      sm{i} = GSM_Complex_Cent_NWarp(ann);
    case 'gsm-complex-cent-concat'
      sm{i} = GSM_Complex_Cent_Concat(ann);
    case 'gsm-complex-noncent-nwarp'
      sm{i} = GSM_Complex_NonCent_NWarp(ann);
    case 'gsm-complex-noncent-concat'
      sm{i} = GSM_Complex_NonCent_Concat(ann);
    % component shape models
    case 'csm-real-nwarp'
      sm{i} = CSM_Real_NWarp(ann,train_db.comp);
    case 'csm-real-concat'
      sm{i} = CSM_Real_Concat(ann,train_db.comp);
    case 'csm-complex-nwarp'
      sm{i} = CSM_Complex_NWarp(ann,train_db.comp);
    case 'csm-complex-concat'
      sm{i} = CSM_Complex_Concat(ann,train_db.comp);
    % part shape models
    case 'psm-real-nwarp'
      sm{i} = PSM_Real_NWarp(ann,train_db.comp);
    case 'psm-real-concat'
      sm{i} = PSM_Real_Concat(ann,train_db.comp);
    case 'psm-complex-nwarp'
      sm{i} = CSM_Complex_NWarp(ann,train_db.comp);
    case 'psm-complex-concat'
      sm{i} = CSM_Complex_Concat(ann,train_db.comp);
  end
  assert(isa(sm{i},'SM') ,'undifiened shape model!');

  % save shape model
  sm{i}.Save(opt.m,i);

end

display('  - warper');

% build ...RF... reference frame
ref_ann = factor * train_ds.ComputeRefAnn(); 
parts = train_ds.parts; 
if n_level == length(opt.m.erode1)
  erode1 = opt.m.erode1{i}; 
else
  erode1 = cell2mat(opt.m.erode1); 
end
if n_level == length(opt.m.erode2)
  erode2 = opt.m.erode2{i};
else
  erode2 = cell2mat(opt.m.erode2);
end
rf = RF(ref_ann,parts,erode1,erode2);
assert(isa(rf,'RF') ,'undifiened reference frame!');

% build ...W... warper
tri = train_ds.tri;
if n_level == length(opt.m.interp)
  interp = opt.m.interp{i};
else
  interp = cell2mat(opt.m.interp);
end
if n_level == length(opt.m.warp)
  warp_type = opt.m.warp{i};
else
  warp_type = cell2mat(opt.m.warp);
end
switch warp_type 
  case 'pwa'
    w{i} = W_PWA(rf,tri,interp);
  case 'tps'
    w{i} = W_TPS(rf,interp); 
end
assert(isa(w{i},'W') ,'undifiened warper!');

display('  - warping images');

% load warped images
[img,loaded] = W.Load(opt.m,i);

if ~loaded
  % warp images
  img = w{i}.WarpSparseDS(train_ds);
  % save warped images
  W.Save(img,opt.m,i);  
end

display('  - texture model');

% load warped images
[tm{i},loaded] = TM.Load(opt.m,i);

if ~loaded

  % build ...S... smoother
  if n_level > 1 && n_level == length(opt.m.shape_model)
    smoother_type = opt.m.smoother{i};
  else
    smoother_type = cell2mat(opt.m.smoother);
    if(isempty(smoother_type))
      smoother_type = '';
    end
  end
  if n_level > 1 && n_level == length(opt.m.sigma)
    sigma = opt.m.sigma{i};
  else
    sigma = cell2mat(opt.m.sigma);
  end
  switch smoother_type
    case 'gaussian'
      smoother = S_Gaus(sigma);
    case 'median'
      smoother = S_Med(sigma);
    otherwise
      smoother = [];
  end

  % build ...T... texture model
  if n_level == length(opt.m.tex_model)
    tex_model_type = opt.m.tex_model{i};
  else
    tex_model_type = cell2mat(opt.m.tex_model);
  end
  if n_level == length(opt.m.tex_model)
    Lp = opt.m.Lp{i};
  else
    Lp = cell2mat(opt.m.Lp);
  end
  img = TM.ColorTransformAll(img);
  switch tex_model_type
    % pixel intensity
    case 'pi'
      tm{i} = GTM_Pi(img,rf,smoother,Lp);
    case 'pi-norm'
      tm{i} = GTM_Pi_Norm(img,rf,smoother,Lp);
    % euler
    case 'euler-real'
      tm{i} = GTM_Euler_Real(img,rf,smoother,opt.m.alpha);
    case 'euler-real-double'
      tm{i} = GTM_Euler_Real_Double(img,rf,smoother,opt.m.alpha);
    case 'euler-complex'
      tm{i} = GTM_Euler_Complex(img,rf,smoother,opt.m.alpha);
    case 'euler-complex-double'
      tm{i} = GTM_Euler_Complex_Double(img,rf,smoother,opt.m.alpha);
    % cootes
    case 'gi-real'
      tm{i} = GTM_Gi_Real(img,rf,smoother,Lp);
    case 'gi-real-double'
      tm{i} = GTM_Gi_Real_Double(img,rf,smoother);
    case 'gi-complex'
      tm{i} = GTM_Gi_Complex(img,rf,smoother);
    case 'gi-complex-double'
      tm{i} = GTM_Gi_Complex_Double(img,rf,smoother);
    % igo
    case 'igo-real'
      tm{i} = GTM_Igo_Real(img,rf,smoother,Lp);
    case 'igo-real-double'
      tm{i} = GTM_Igo_Real_Double(img,rf,smoother,Lp);
    case 'igo-complex'
      tm{i} = GTM_Igo_Complex(img,rf,smoother);
    case 'igo-complex-double'
      tm{i} = GTM_Igo_Complex_Double(img,rf,smoother);
    % hog
    case 'hog'
      tm{i} = GTM_Hog(img,rf,smoother,opt.m.cell_size, ...
        opt.m.n_orientation);
  end
  assert(isa(tm{i},'TM') ,'undifiened texture model!');

  % save shape model
  tm{i}.Save(opt.m,i);

end

