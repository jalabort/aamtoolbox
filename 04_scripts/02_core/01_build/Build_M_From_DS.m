display('- loading model');

% load model
[m,loaded] = M_2D.Load(opt.m);

if ~loaded
  
  display('- model not found');
  display('- building model');
  display(' - loading training dataset');
  
  % load training dataset
  [train_ds,loaded] = train_db.Load(opt.m.reg_exp_query);
  
  if loaded

    n_level = length(opt.m.level);
    
    w =  cell(n_level,1);
    sm = cell(n_level,1);
    tm =  cell(n_level,1);

    for i = 1:n_level

      display([' - computing level: ' int2str(i) '/' int2str(n_level)]);
      
      factor = opt.m.level{i};
      
      display ('  - shape model');
      
      % build ...SM... shape model
      ann = factor * train_ds.GetAnn();
      if n_level == length(opt.m.shape_model)
        shape_model_type = opt.m.shape_model{i};
      else
        shape_model_type = cell2mat(opt.m.shape_model);
      end
      switch shape_model_type  
        % global shape models
        case 'gsm-real-nwarp'
          sm{i} = GSM_Real_NWarp(ann);
        case 'gsm-real-concat'
          sm{i} = GSM_Real_Concat(ann);
        case 'gsm-complex-cent-nwarp'
          sm{i} = GSM_Complex_NWarp(ann);
        case 'gsm-complex-cent-concat'
          sm{i} = GSM_Complex_Concat(ann);
        case 'gsm-complex-noncent-nwarp'
          sm{i} = GSM_Complex_NWarp(ann);
        case 'gsm-complex-noncent-concat'
          sm{i} = GSM_Complex_Concat(ann);
        % component shape models
        case 'csm-real-nwarp'
          sm{i} = CSM_Real_NWarp(ann);
        case 'csm-real-concat'
          sm{i} = CSM_Real_Concat(ann);
        case 'csm-complex-nwarp'
          sm{i} = CSM_Complex_NWarp(ann);
        case 'csm-complex-concat'
          sm{i} = CSM_Complex_Concat(ann);
        % parts shape models
        case 'psm-real-nwarp'
          sm{i} = PSM_Real_NWarp(ann);
        case 'psm-real-concat'
          sm{i} = PSM_Real_Concat(ann);
        case 'psm-complex-nwarp'
          sm{i} = CSM_Complex_NWarp(ann);
        case 'psm-complex-concat'
          sm{i} = CSM_Complex_Concat(ann);
      end
      
      assert(isa(sm{i},'SM') ,'undifiened shape model!')
          
      display('  - warper');
      
      % create ...RF... reference frame
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
      
      assert(isa(rf,'RF') ,'undifiened reference frame!')

      % create ...W... warper
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
          w{i} = W_PWA(rf,interp); 
      end
      
      assert(isa(w{i},'W') ,'undifiened warper!')
      
      display('  - warping images');
      
      % warp
      img = w{i}.WarpDS(train_ds);
      
      display('  - texture model');

      % smoother
      if n_level == length(opt.m.shape_model)
        smoother_type = opt.m.smoother{i};
      else
        smoother_type = cell2mat(opt.m.smoother);
        if(isempty(smoother_type))
          smoother_type = '';
        end
      end
      if n_level == length(opt.m.sigma)
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
      
      % texture model
      if n_level == length(opt.m.tex_model)
        tex_model_type = opt.m.tex_model{i};
      else
        tex_model_type = cell2mat(opt.m.tex_model);
      end
      img = TM.ColorTransformAll(img);
      switch tex_model_type
        % pixel intensity
        case 'pi'
          tm{i} = GTM_Pi(img,rf,smoother);
        case 'pi-norm'
          tm{i} = GTM_Pi_Norm(img,rf,smoother);
        % euler
        case 'euler-real'
          tm{i} = GTM_Euler_Real(img,rf,smoother);
        case 'euler-real-double'
          tm{i} = GTM_Euler_Real_Double(img,rf,smoother);
        case 'euler-complex'
          tm{i} = GTM_Euler_Complex(img,rf,smoother);
        case 'euler-complex-double'
          tm{i} = GTM_Euler_Complex_Double(img,rf,smoother);
        % cootes
        case 'gi-real'
          tm{i} = GTM_Gi_Real(img,rf,smoother);
        case 'gi-real-double'
          tm{i} = GTM_Gi_Real_Double(img,rf,smoother);
        case 'gi-complex'
          tm{i} = GTM_Gi_Complex(img,rf,smoother);
        case 'gi-complex-double'
          tm{i} = GTM_Gi_Complex_Double(img,rf,smoother);
        % igo
        case 'igo-real'
          tm{i} = GTM_Igo_Real(img,rf,smoother);
        case 'igo-rea-double'
          tm{i} = GTM_Igo_Real_Double(img,rf,smoother);
        case 'igo-complex'
          tm{i} = GTM_Igo_Complex(img,rf,smoother);
        case 'igo-complex-double'
          tm{i} = GTM_Igo_Complex_Double(img,rf,smoother);
      end
      
      assert(isa(tm{i},'TM') ,'undifiened texture model!')
     
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
    
  else
    
    display(' - training dataset could not be loaded!');
  
  end
  
end

