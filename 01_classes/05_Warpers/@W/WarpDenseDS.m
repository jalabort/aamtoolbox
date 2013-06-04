function [wimg] = WarpDenseDS(obj,ds)
  %WarpDenseDS Summary of this function goes here
  %   Detailed explanation goes here
  
  wimg = zeros([obj.rf.res,ds.n_ch,ds.n_data]);
  
  for i = 1:ds.n_data
    if size(ds.data{i}.img,3) < ds.n_ch
      ds.data{i}.img(:,:,2) = ds.data{i}.img(:,:,1);
      ds.data{i}.img(:,:,3) = ds.data{i}.img(:,:,1);
    end
    wimg(:,:,:,i) = obj.WarpDense(ds.data{i}.ann,double(ds.data{i}.img)/255);
  end

end

