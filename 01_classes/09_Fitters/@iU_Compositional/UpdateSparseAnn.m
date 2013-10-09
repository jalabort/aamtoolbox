function [ann,p] = UpdateSparseAnn(obj,i,ann,delta,p)
  %UpdateSparseAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  if length(delta) == obj.sm{i}.n_p
    [ann,p] = obj.w{i}.UpdateSparseAnn(obj.sm{i},ann,delta,p);
  else
    delta_t = delta(1:obj.sm{i}.n_p);
    [ann,p] = obj.w{i}.UpdateSparseAnn(obj.sm{i},ann,delta_t,p);
    delta_i = delta(obj.sm{i}.n_p+1:end);
    [ann,p] = obj.w{i}.UpdateSparseAnn(obj.sm{i},ann,delta_i,p);
  end
end

