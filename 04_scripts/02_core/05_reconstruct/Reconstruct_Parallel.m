parfor i = 1:test_ds.n_data

  % fit image
  ann = f.Reconstruct(test_ds.data{i}.ann);
  rann(:,:,:,i) = ann(:,:,:,end); 

end