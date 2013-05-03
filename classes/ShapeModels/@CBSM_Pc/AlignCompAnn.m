function [new_mean_cent_ann,mass_ann,comp_ann] = AlignCompAnn(obj,ann,n_ann)
  %ALIGNCOMPANN Summary of this function goes here
  %   Detailed explanation goes here
  
  cent_ann = ann - repmat(mean(ann,1),[obj.n_vert 1 1]);
  
  mean_cent_ann = mean(cent_ann,3);
  div_err = 1; e = 1e-20; it = 1; max_it = 100;
  while div_err >= e && it <= max_it 
    for i = 1:n_ann       
      [~,cent_ann(:,:,i)] = procrustes(mean_cent_ann,cent_ann(:,:,i));
    end
    new_mean_cent_ann = mean(cent_ann,3);
    [div_err,mean_cent_ann] = procrustes(mean_cent_ann,new_mean_cent_ann);
    it = it + 1;  
  end
  
  mass_ann = zeros(obj.n_vert,2,n_ann);
  comp_ann = mass_ann;
  for i = 1:obj.n_comp
    cent_comp = mean(cent_ann(obj.i_comp_ann{i},:,:),1);
    n_vert_comp = length(obj.i_comp_ann{i});
    mass_ann(obj.i_comp_ann{i},:,:) = repmat(cent_comp,[n_vert_comp 1 1]);
    comp_ann(obj.i_comp_ann{i},:,:) = cent_ann(obj.i_comp_ann{i},:,:) - repmat(cent_comp,[n_vert_comp 1 1]);
  end
  
end

