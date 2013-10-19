function [obj] = PreComputeSparse(obj,i)
  %PreComputeSparse Summary of this function goes here
  %   Detailed explanation goes here
  
  obj.t{i} = obj.tm{i}.GetMean();
  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(obj.t{i});

  dWduvi = obj.w{i}.Compute_dWduvi();
  obj.dWdp{i} = obj.sm{i}.Compute_dWdp(dWduvi);
  
  obj.Jt{i} = obj.tm{i}.Compute_dtdp(dtdx,dtdy,obj.dWdp{i});
  
  obj.tm{i}.sigma_ck = diag(obj.tm{i}.ev(1:obj.tm{i}.n_c));
  
  %-----
  if obj.shape_reg ~= 0
    obj.w{i}.inv_sigma_p0 = diag(1./[obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1:obj.sm{i}.n_b)]); 
    obj.w{i}.sigma_p0 = diag([obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1:obj.sm{i}.n_b)]);
    obj.w{i}.sigma_pk = zeros(size(obj.w{i}.sigma_p0));
  end
  if obj.tex_reg ~= 0
    obj.tm{i}.sigma_ckk = diag(obj.tm{i}.ev(1:obj.tm{i}.n_c));
    obj.tm{i}.sigma_c0 = diag(obj.tm{i}.ev(1:obj.tm{i}.n_c));
  end
  %-----
  
end

