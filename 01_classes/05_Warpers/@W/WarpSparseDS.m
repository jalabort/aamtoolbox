function [wimg] = WarpSparseDS(obj,ds)
  %WarpSparseDS Summary of this function goes here
  %   Detailed explanation goes here
  
  wimg = zeros([obj.rf.res,ds.n_ch,ds.n_data]);
  
  for i = 1:ds.n_data
    wimg(:,:,:,i) = obj.WarpSparse(ds.data{i}.ann,ds.data{i}.img);
  end

end

