for i = 1:n_fittings
  
  j = floor((i-1)/n_rand) + 1;
  
  % fit image
  if opt.m.dense
    [fit,ini,ori] = f.FitDense(test_ds.data{j}.img,test_ds.data{j}.ann);
  else
    [fit,ini,ori] = f.FitSparse(test_ds.data{j}.img,test_ds.data{j}.ann);
  end
  fann(:,:,i) = fit(:,:,end);
  iann(:,:,i) = ini;
  oann(:,:,i) = ori;
  
  % show the fitting
  if opt.show
    if all(all(fit(:,:,end)))
      h = 1;
      aamshow(h,test_ds.data{j}.img,fit,test_db.parts);
    end
    % save images
    if opt.save_img
      frame = getframe(h);
      imwrite(frame.cdata,[opt.img_root int2str(i)],'png'); 
    end
  end

  % print the error
  if opt.verbose 
    if all(all(fit(:,:,end)))
      [rms_err,p2p_err,ram_err,hel_err] = computeerr(fit(:,:,end), ...
        test_ds.data{j}.ann, ...
        test_ds.data{j}.ann, ...
        test_db.comp);
      fprintf(['  - img: ' int2str(j) '/' int2str(test_ds.n_data) ...
        '\t\t  rms_err: ' num2str(rms_err) ...
        '\t  p2p_err: ' num2str(p2p_err) ...
        '\t  ram_err: ' num2str(ram_err) ...
        '\t  hel_err: ' num2str(hel_err) ...
        '\n']);
    else
      fprintf([' - image: ' int2str(j) '/' int2str(test_ds.n_data) ...
        '\t face not detected!' ...
        '\n']);
    end
  end
  
end