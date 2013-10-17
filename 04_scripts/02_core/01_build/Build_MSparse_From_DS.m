display ('  - shape model');

% load shape model
[sm_,loaded] = SM.Load(opt.m);

if ~loaded

  % build ...SM... shape model
  ann = train_ds.GetAnn();
  switch opt.m.shape_model  
    % global shape models
    case 'gsm-real-nwarp'
      sm_ = GSM_Real_NWarp(ann);
    case 'gsm-real-concat'
      sm_ = GSM_Real_Concat(ann);
    case 'gsm-euler-real-nwarp'
      sm_ = GSM_Euler_Real_NWarp(ann,opt.m.alpha);
    case 'gsm-complex-cent-nwarp'
      sm_ = GSM_Complex_Cent_NWarp(ann);
    case 'gsm-complex-cent-concat'
      sm_ = GSM_Complex_Cent_Concat(ann);
    case 'gsm-complex-noncent-nwarp'
      sm_ = GSM_Complex_NonCent_NWarp(ann);
    case 'gsm-complex-noncent-concat'
      sm_ = GSM_Complex_NonCent_Concat(ann);
    % component shape models
    case 'csm-real-nwarp'
      sm_ = CSM_Real_NWarp(ann,train_db.comp);
    case 'csm-real-concat'
      sm_ = CSM_Real_Concat(ann,train_db.comp);
    case 'csm-complex-nwarp'
      sm_ = CSM_Complex_NWarp(ann,train_db.comp);
    case 'csm-complex-concat'
      sm_ = CSM_Complex_Concat(ann,train_db.comp);
    % part shape models
    case 'psm-real-nwarp'
      sm_ = PSM_Real_NWarp(ann,train_db.comp);
    case 'psm-real-concat'
      sm_ = PSM_Real_Concat(ann,train_db.comp);
    case 'psm-complex-nwarp'
      sm_ = CSM_Complex_NWarp(ann,train_db.comp);
    case 'psm-complex-concat'
      sm_ = CSM_Complex_Concat(ann,train_db.comp);
  end
  assert(isa(sm_,'SM') ,'undifiened shape model!');

  % save shape model
  sm_.Save(opt.m);

end

display('  - warper');

% build ...RF... reference frame
ref_ann = train_ds.ComputeRefAnn(); 
parts = train_ds.parts; 
rf = RF(ref_ann,parts,opt.m.erode1,opt.m.erode2);
assert(isa(rf,'RF') ,'undifiened reference frame!');

% build ...W... warper
tri = train_ds.tri;
switch opt.m.warp 
  case 'pwa'
    w_ = W_PWA(rf,tri,opt.m.interp);
  case 'tps'
    w_ = W_TPS(rf,opt.m.interp); 
end
assert(isa(w_,'W') ,'undifiened warper!');

% for every level
for i = 1:n_level
  
  sm{i} = sm_;
  w{i} = w_;
  
  display([' - computing level: ' int2str(i) '/' int2str(n_level)]);

  display('  - warping images');

  factor = opt.m.level{i};
  if n_level == length(opt.m.feature)
    feature_type = opt.m.feature{i};
  else
    feature_type = cell2mat(opt.m.feature);
  end

  % load warped images
  [img,loaded] = W.Load(opt.m,i);

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
        smoother{i} = S_Gaus(sigma);
      case 'median'
        smoother{i} = S_Med(sigma);
      otherwise
        smoother{i} = [];
    end
    
    % normalize face size
    train_ds2 = train_ds.NormalizeFaceSize(sm_);
    % multiresolution
    train_ds2 = train_ds2.Scale(factor,smoother{i});
    % compute features if necessary
    if n_level == length(opt.m.tex_alpha)
      alpha = opt.m.tex_alpha{i}; 
    else
      alpha = cell2mat(opt.m.tex_alpha); 
    end
    train_ds2 = train_ds2.ToIntensity();
    switch feature_type
      case 'igo'
        train_ds2 = train_ds2.ToIgo();
      case 'igo-double'
        train_ds2 = train_ds2.ToIgoDouble();
      case 'gi'
        train_ds2 = train_ds2.ToGi();
      case 'gi-double'
        train_ds2 = train_ds2.ToGiDouble();
      case 'euler'
        train_ds2 = train_ds2.ToEuler(alpha);
      case 'euler-double'
        train_ds2 = train_ds2.ToEulerDouble(alpha);
    end
    % warp images
    img = w_.WarpSparseDS(train_ds2);
    % save warped images
    W.Save(img,opt.m,i); 
    clear train_ds2
    
  end

  display('  - texture model');

  % load warped images
  [tm{i},loaded] = TM.Load(opt.m,i);

  if ~loaded

    % build ...T... texture model
    if n_level == length(opt.m.tex_model)
      tex_model_type = opt.m.tex_model{i};
    else
      tex_model_type = cell2mat(opt.m.tex_model);
    end
    if n_level == length(opt.m.tex_model)
      lp = opt.m.tex_lp{i};
    else
      lp = cell2mat(opt.m.tex_lp);
    end
    switch tex_model_type
      % centered
      case 'cent'
        tm{i} = GTM_Cent(img,rf,lp);
      % centered with feature normalization
      case 'cent-norm'
        tm{i} = GTM_Cent_Norm(img,rf,lp);
      % noncet
      case 'noncent'
        tm{i} = GTM_NonCent(img,rf,lp);
      % centered with feature normalization
      case 'noncent-norm'
        tm{i} = GTM_NonCent_Norm(img,rf,lp);
    end
    tm{i}.factor = factor;
    tm{i}.feature_type = feature_type;
    assert(isa(tm{i},'TM') ,'undifiened texture model!');

    % save shape model
    tm{i}.Save(opt.m,i);

  end
  
end

