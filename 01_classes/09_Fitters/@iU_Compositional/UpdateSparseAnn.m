function [ann,p] = UpdateSparseAnn(obj,i,ann,delta,p)
  %UpdateSparseAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  if length(delta) == obj.sm{i}.n_p
    [ann,p] = obj.w{i}.UpdateSparseAnn(obj.sm{i},ann,delta,p);
  else
    delta_t = delta(1:obj.sm{i}.n_p);
    delta_i = delta(obj.sm{i}.n_p+1:end);
    ann_i = obj.sm{i}.P2Ann(delta_i);
    [~,delta_it] = obj.w{i}.UpdateSparseAnn(obj.sm{i},ann_i,delta_t,delta_i);
    [ann,p] = obj.w{i}.UpdateSparseAnn(obj.sm{i},ann,delta_it,p);
  end
  
end