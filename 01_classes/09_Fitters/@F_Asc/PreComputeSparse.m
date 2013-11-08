function [obj] = PreComputeSparse(obj,i)
  %PreComputeSparse Summary of this function goes here
  %   Detailed explanation goes here

  dWduvi = obj.w{i}.Compute_dWduvi();
  obj.dWdp{i} = obj.sm{i}.Compute_dWdp(dWduvi);
  
  %-----
  if obj.shape_reg ~= 0
    obj.w{i}.sigma_p0 = diag([100,100,100,100,obj.sm{i}.ev(1:obj.sm{i}.n_b)]);
    obj.w{i}.sigma_pk = zeros(size(obj.w{i}.sigma_p0));
  end
  if obj.tex_reg ~= 0
    obj.sigma_ck{i} = obj.tm{i}.variance * obj.tm{i}.pc(:,1:obj.tm{i}.n_c)' * obj.tm{i}.pc(:,1:obj.tm{i}.n_c);
    obj.tm{i}.sigma_c0 = diag(obj.tm{i}.ev(1:obj.tm{i}.n_c));
  end
  %-----
  
end

