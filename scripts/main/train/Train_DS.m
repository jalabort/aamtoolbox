display('- Loading Model');

[m,loaded] = M_2D.Load(opt.m);

if ~loaded
  
  display('- Model not found');
  display('- Creating model');
  display(' - Loading training dataset');
  
  [train_ds,loaded2] = train_db.Load(opt.m.train_reg_exp_query);
  
  if loaded2

    w =  cell(opt.m.n_level,1);
    sm = cell(opt.m.n_level,1);
    tm =  cell(opt.m.n_level,1);

    for i = 1:opt.m.n_level

      display([' - Level: ' int2str(i) '']);

      factor = 1 * opt.m.factor{i};

      display('  - Warper');

      [ref_ann] = train_ds.ComputeRefAnn();
      ref_ann = ref_ann .* factor;

      rf = RF(ref_ann,train_ds.n_vert,train_ds.parts,train_ds.n_parts,opt.m.erode);

      switch opt.m.warp 
        case 'pwa'
          w{i} = W_PWA(rf,train_ds.tri,train_ds.n_tri,opt.m.interp);  
        case 'tps'
          w{i} = W_TPS(rf,opt.m.interp);   
      end

      display('  - Shape Model');

      ann = train_ds.getAnn() .* factor;

      switch opt.m.shape_model{i}
        case 'pc'
          sm{i} = SM_Pc(ann,train_ds.n_vert,train_ds.n_data);
        case 'pc2'
          sm{i} = SM_Pc2(ann,train_ds.n_vert,train_ds.n_data);
        case 'pc3'
          sm{i} = SM_Pc3(ann,train_ds.n_vert,train_ds.n_data,train_ds.comp,train_ds.n_comp);
        case 'pc-complex'
          sm{i} = SM_Pc_Complex(ann,train_ds.n_vert,train_ds.n_data);
        case 'cb-pc'
          sm{i} = CBSM_Pc(ann,train_ds.n_vert,train_ds.n_data,train_ds.comp,train_ds.n_comp);
        case 'cb-pc2'
          sm{i} = CBSM_Pc2(ann,train_ds.n_vert,train_ds.n_data,train_ds.comp,train_ds.n_comp);
        case 'cb-pc3'
          sm{i} = CBSM_Pc3(ann,train_ds.n_vert,train_ds.n_data,train_ds.comp,train_ds.n_comp);
        case 'cb-pc4'
          sm{i} = CBSM_Pc4(ann,train_ds.n_vert,train_ds.n_data,train_ds.comp,train_ds.n_comp);
        case 'cb-pc5'
          sm{i} = CBSM_Pc5(ann,train_ds.n_vert,train_ds.n_data,train_ds.comp,train_ds.n_comp);
        case 'cb-pc6'
          sm{i} = CBSM_Pc6(ann,train_ds.n_vert,train_ds.n_data,train_ds.comp,train_ds.n_comp);
      end

      display('  - Texture Model');

      img = w{i}.WarpDS(train_ds);

      switch opt.m.smoothing
        case 'none'
          smoother = S_None();
        case 'gaussian'
          smoother = S_Gaus(opt.m.sigma{i});
        case 'median'
          smoother = S_Med(opt.m.sigma{i});
      end

      switch opt.m.tex_model
        case 'pi'
          tm{i} = TM_Pi(img,train_ds.n_data,rf.mask,rf.n_face_pixels,rf.res,rf.mask2,rf.n_face_pixels2,smoother,opt.m.g_type);
        case 'euler'
          tm{i} = TM_Euler(img,train_ds.n_data,rf.mask,rf.n_face_pixels,rf.res,rf.mask2,rf.n_face_pixels2,smoother,opt.m.g_type,opt.m.alpha);
        case 'euler-complex'
          tm{i} = TM_Euler_Complex(img,train_ds.n_data,rf.mask,rf.n_face_pixels,rf.res,rf.mask2,rf.n_face_pixels2,smoother,opt.m.g_type,opt.m.alpha);
        case 'euler-double'
          tm{i} = TM_Euler_Double(img,train_ds.n_data,rf.mask,rf.n_face_pixels,rf.res,rf.mask2,rf.n_face_pixels2,smoother,opt.m.g_type,opt.m.alpha);
        case 'gi'
          tm{i} = TM_Gi(img,train_ds.n_data,rf.mask,rf.n_face_pixels,rf.res,rf.mask2,rf.n_face_pixels2,smoother,opt.m.g_type);
        case 'igo'
          tm{i} = TM_Igo(img,train_ds.n_data,rf.mask,rf.n_face_pixels,rf.res,rf.mask2,rf.n_face_pixels2,smoother,opt.m.g_type);
        case 'igo-complex'
          tm{i} = TM_Igo_Complex(img,train_ds.n_data,rf.mask,rf.n_face_pixels,rf.res,rf.mask2,rf.n_face_pixels2,smoother,opt.m.g_type);
        case 'igo-double'
          tm{i} = TM_Igo_Double(img,train_ds.n_data,rf.mask,rf.n_face_pixels,rf.res,rf.mask2,rf.n_face_pixels2,smoother,opt.m.g_type);
      end
     
    end

    clear loaded loaded2 contour ref_ann rf ann img factor train_ds smoother 
    m = M_2D(i,w,sm,tm);
    clear i w sm tm
    m.Save(opt.m);

    display('- Model saved');
    
  else
    
    display(' - Training dataset could not be loaded!'); 
    
  end
  
end


