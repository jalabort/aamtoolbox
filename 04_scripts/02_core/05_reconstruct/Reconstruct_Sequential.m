for i =1:test_ds.n_data

  % fit image
  ann = f.Reconstruct(test_ds.data{i}.ann);
  rann(:,:,:,i) = ann(:,:,:,end); 

  % show the fitting
  if opt.show
    if all(all(ann(:,:,end)))
      h = 1;
      aamshow(h,test_ds.data{i}.img,ann,test_db.parts);
    end
  end

end