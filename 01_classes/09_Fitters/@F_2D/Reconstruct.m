function [rann] = Reconstruct(obj,ann)
  %Reconstruct Summary of this function goes here
  %   Detailed explanation goes here
  
  rann = zeros([size(obj.sm{1}.mu_ann),obj.n_level]);
  
  for i = 1:obj.n_level     
    rann(:,:,i)  = obj.sm{i}.ProjectAnn(ann);
  end
  
end

