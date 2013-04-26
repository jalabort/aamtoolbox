display('- Loading test dataset');

[test_ds,loaded] = test_db.Load(opt.test_reg_exp_query);

if loaded
  
  display('- Creating fitter');
  
  switch opt.algorithm
    case 'pic-ssd'
      f = F_PicSsd(m);
    case 'pic-ecc'
      f = F_PicEcc(m);
    case 'aic-ssd'
      f = F_AicSsd(m);
    case 'daic-ssd'
      f = F_DaicSsd(m);
    case 'afc-ssd'
      f = F_AfcSsd(m);
    case 'aic-ecc'
      f = F_AicEcc(m);
    case 'daic-ecc'
      f = F_DaicEcc(m);
    case 'sic-ssd'
      f = F_SicSsd(m);
    case 'sic-ecc'
      f = F_SicEcc(m);
  end
  clear m

  if strcmp(opt.m.warp,'pwa')
    switch opt.composition 
      case 'baker'
        for i = 1:f.n_level
          f.w{i} = W_PWA_1(f.w{i});
        end
      case 'papandreou'
        for i = 1:f.n_level
          f.w{i} = W_PWA_2(f.w{i});
        end
    end
  end
  
  switch opt.m.tex_model 
    case 'df-igo'
      for i = 1:f.n_level
        f.tm{i}.n_bin = opt.n_bin{i};
        f.tm{i}.bin = f.tm{i}.SetBin();
        siz = 2*opt.sigma{i}+1;
        H = fspecial3('gaussian',[siz siz siz],opt.sigma{i});
        f.tm{i}.smoother.H = H;
      end
  end
 
  switch opt.face_detector 
    case 'gr-tr'
      f.face_det = FD_GrTr();
    case 'matlab'
      f.face_det = FD_Mat();
  end
  
  for i = 1:f.n_level
    f.tm{i}.n_c = opt.n_c{i};
    if strcmp(opt.m.shape_model{i}(1:2),'cb')
      f.sm{i}.n_p = opt.n_p2{i};
      f.sm{i}.n_r = [opt.n_r{:,i}];
      f.sm{i}.n_qpr = f.sm{i}.n_q + opt.n_p2{i} + sum([opt.n_r{:,i}]);
    else
      f.sm{i}.n_p = opt.n_p1{i};
      f.sm{i}.n_qpr = f.sm{i}.n_q  + opt.n_p1{i};
    end
  end

  f.n_it = opt.n_it;
  f.show_fitting = opt.show_fitting;
  
  display('- Initializing fitter');
  
  f = f.Initialize();

  display('- Fitting');
  
  fann = zeros(train_db.n_vert,2,test_ds.n_data);
  
  for i = 1:test_ds.n_data

    fann(:,:,i) = f.Fit(test_ds.data{i});

    if opt.show_error
      face_size = mean(max(test_ds.data{i}.ann) - min(fann(:,:,i)));
      err = mean(sqrt(sum((test_ds.data{i}.ann - fann(:,:,i)).^2,2))) ./ face_size;
      disp([' - Image: ' int2str(i) '/' int2str(test_ds.n_data) '\t Error: ' num2str(err)]);
    end
    
    if mod(i,10) == 0 
        Test_Helen2
    end

  end
  
else
  
  display('- Testing dataset could not be loaded!'); 
  
end

