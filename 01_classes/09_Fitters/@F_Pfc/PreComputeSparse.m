function [obj] = PreComputeSparse(obj,i)
  %PreComputeSparse Summary of this function goes here
  %   Detailed explanation goes here
  
  obj.t{i} = obj.tm{i}.GetMean();

  dWduvi = obj.w{i}.Compute_dWduvi();
  obj.dWdp{i} = obj.sm{i}.Compute_dWdp(dWduvi);
  
  %-----
  if obj.shape_reg ~= 0
    obj.w{i}.inv_sigma_p0 = diag(1./[obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1:obj.sm{i}.n_b)]); 
    obj.w{i}.sigma_p0 = diag([obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1:obj.sm{i}.n_b)]);
    obj.w{i}.sigma_pk = zeros(size(obj.w{i}.sigma_p0));
  end
  %-----
  
end

