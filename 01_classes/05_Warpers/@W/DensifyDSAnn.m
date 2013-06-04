function [ann] = DensifyDSAnn(obj,ds)
  %DensifyDSAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  ann = zeros(obj.rf.n_vert+obj.rf.n_face_pixels1,2,ds.n_data);
  
  for i = 1:ds.n_data
    [res(1),res(2),~] = size(ds.data{i}.img);
    xy = obj.Compute_Wuv(ds.data{i}.ann,res);
    ann(:,:,i) = [ds.data{i}.ann;xy];
  end

end

