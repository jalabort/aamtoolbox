% compute error per component
cerr = zeros(test_ds.n_data,test_ds.n_comp);
for j = 1:test_ds.n_comp
  for i = 1:test_ds.n_data
    [rms_err,p2p_err,ram_err,hel_err] = ...
      computeerr(fann(test_ds.comp{j},:,i), ...
      test_ds.data{i}.ann(test_ds.comp{j},:), ...
      test_ds.data{i}.ann, ...
      test_ds.comp);
    switch opt.err_type
      case 'rms'
        cerr(i,j) = rms_err;
      case 'p2p'
        cerr(i,j) = p2p_err;
      case 'ram'
        cerr(i,j) = ram_err;
      case 'hel'
        cerr(i,j) = hel_err;
    end
  end
end

perr = zeros(test_ds.n_data,test_ds.n_vert);
for j = 1:test_ds.n_vert
  for i = 1:test_ds.n_data
    [rms_err,p2p_err,ram_err,hel_err] = ...
      computeerr(fann(j,:,i), ...
      test_ds.data{i}.ann(j,:), ...
      test_ds.data{i}.ann, ...
      test_ds.comp);
    switch opt.err_type
      case 'rms'
        perr(i,j) = rms_err;
      case 'p2p'
        perr(i,j) = p2p_err;
      case 'ram'
        perr(i,j) = ram_err;
      case 'hel'
        perr(i,j) = hel_err;
    end
  end
end

