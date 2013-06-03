function [point_err] = computepointerr(test_ds,err_type,fann)
  %computepointerr Summary of this function goes here
  %   Detailed explanation goes here

  point_err = zeros(test_ds.n_data,test_ds.n_vert);
  for j = 1:test_ds.n_vert
    for i = 1:test_ds.n_data
      [rms_err,p2p_err,ram_err,hel_err] = ...
        computeerr(fann(j,:,i), ...
        test_ds.data{i}.ann(j,:), ...
        test_ds.data{i}.ann, ...
        test_ds.comp);
      switch err_type
        case 'rms'
          point_err(i,j) = rms_err;
        case 'p2p'
          point_err(i,j) = p2p_err;
        case 'ram'
          point_err(i,j) = ram_err;
        case 'hel'
          point_err(i,j) = hel_err;
      end
    end
  end

end