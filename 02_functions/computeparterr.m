function [part_err] = computeparterr(test_ds,err_type,fann)
  %computeparterr Summary of this function goes here
  %   Detailed explanation goes here

  part_err = zeros(test_ds.n_data,test_ds.n_comp);
  for j = 1:test_ds.n_comp
    for i = 1:test_ds.n_data
      [rms_err,p2p_err,ram_err,hel_err] = ...
        computeerr(fann(test_ds.comp{j},:,i), ...
        test_ds.data{i}.ann(test_ds.comp{j},:), ...
        test_ds.data{i}.ann, ...
        test_ds.comp);
      switch err_type
        case 'rms'
          part_err(i,j) = rms_err;
        case 'p2p'
          part_err(i,j) = p2p_err;
        case 'ram'
          part_err(i,j) = ram_err;
        case 'hel'
          part_err(i,j) = hel_err;
      end
    end
  end
  
end