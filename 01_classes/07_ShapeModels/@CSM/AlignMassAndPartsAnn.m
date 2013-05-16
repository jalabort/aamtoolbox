function [mass_ann,part_ann,new_mu] = AlignMassAndPartsAnn(obj,ann)
  %AlignMassAndPartsAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  n_ann = size(ann,3);
  
  cann = ann - repmat(mean(ann,1),[obj.n_vert 1 1]);
  mu = mean(cann,3);
  
  err = 1; e = 1e-20; it = 1; max_it = 100;
  while err >= e && it <= max_it 
    for i = 1:n_ann       
      [~,cann(:,:,i)] = procrustes(mu,cann(:,:,i));
    end
    new_mu = mean(cann,3);
    err = mean(sum((mu - new_mu).^2,2));
    [~,mu] = procrustes(mu,new_mu);
    it = it + 1;  
  end
  
  mass_ann = zeros(obj.n_vert,2,n_ann);
  part_ann = zeros(size(ann));
  for i = 1:obj.n_part
    cent_part = mean(cann(obj.i_part_ann{i},:,:),1);
    n_vert_part = length(obj.i_part_ann{i});
    mass_ann(obj.i_part_ann{i},:,:) = repmat(cent_part,[n_vert_part 1 1]);
    part_ann(obj.i_part_ann{i},:,:) = cann(obj.i_part_ann{i},:,:) - repmat(cent_part,[n_vert_part 1 1]);
  end
end

