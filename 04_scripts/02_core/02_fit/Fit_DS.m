display('- loading test dataset');

% load training dataset
[test_ds,loaded] = test_db.Load(opt.reg_exp_query);

if loaded
  
  display('- fitting');
  
  fann = zeros(train_db.n_vert,2,test_ds.n_data);
  
  for i = 1:test_ds.n_data

    ann = f.Fit(test_ds.data{i}.img,test_ds.data{i}.ann);
    fann(:,:,i) = ann(:,:,end); 
    
    if opt.show
      aamshow(1,test_ds.data{i}.img,ann);
    end
    
    if verbose
      [rms_err,p2p_err,ram_err,hel_err] = compute_error(fann(:,:,i),...
        test_ds.data{i}.ann);
      disp([' - image: ' int2str(i) '/' int2str(test_ds.n_data) ...
        '\t rms_err: ' num2str(rms_err) ...
        '\t p2p_err: ' num2str(p2p_err) ...
        '\t ram_err: ' num2str(ram_err) ...
        '\t hel_err: ' num2str(hel_err)]);
    end
    
  end
  
else
  
  display('- test dataset could not be loaded!'); 
  
end

