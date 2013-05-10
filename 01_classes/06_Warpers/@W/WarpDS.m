function [wimg] = WarpDS(obj,ds)
  %WARPDS Summary of this function goes here
  %   Detailed explanation goes here
  
  wimg = zeros([obj.rf.res,ds.n_ch,ds.n_data]);
  
  for i = 1:ds.n_data
    wimg(:,:,:,i) = obj.Warp(ds.data{i}.ann,double(ds.data{i}.img)/255);
  end

end

