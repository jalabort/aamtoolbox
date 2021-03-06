parfor i = 1:test_ds.n_data

  % fit image
  ann = f.Fit(test_ds.data{i}.img,test_ds.data{i}.ann);
  fann(:,:,i) = ann(:,:,end); 

  % print the error
  if opt.verbose 
    if all(all(ann(:,:,end)))
      [rms_err,p2p_err,ram_err,hel_err] = computeerr(fann(:,:,i), ...
        test_ds.data{i}.ann, ...
        test_ds.data{i}.ann, ...
        test_db.comp);
      fprintf(['  - img: ' int2str(i) '/' int2str(test_ds.n_data) ...
        '\t\t  rms_err: ' num2str(rms_err) ...
        '\t  p2p_err: ' num2str(p2p_err) ...
        '\t  ram_err: ' num2str(ram_err) ...
        '\t  hel_err: ' num2str(hel_err) ...
        '\n']);
    else
      fprintf([' - image: ' int2str(i) '/' int2str(test_ds.n_data) ...
        '\t face not detected!' ...
        '\n']);
    end
  end

end