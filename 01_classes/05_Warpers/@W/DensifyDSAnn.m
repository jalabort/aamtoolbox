function [ann] = DensifyDSAnn(obj,ds)
  %DensifyDSAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  ann = zeros(obj.rf.n_vert+obj.rf.n_face_pixels1,2,ds.n_data);
  aux1 = zeros(size(obj.rf.mask1));
  aux2 = aux1;
  
  for i = 1:ds.n_data
    [res(1),res(2),~] = size(ds.data{i}.img);
    xy = obj.Compute_Wuv(ds.data{i}.ann,res);
    aux1(obj.rf.uv_vec) = xy(:,1);
    aux2(obj.rf.uv_vec) = xy(:,2);
    xy(:,1) = aux1(obj.rf.mask1);
    xy(:,2) = aux2(obj.rf.mask1);
    ann(:,:,i) = [ds.data{i}.ann;xy];
  end

end

