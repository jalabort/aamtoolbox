function [obj] = PreComputeDense(obj,i)
  %PreComputeDense Summary of this function goes here
  %   Detailed explanation goes here
  
  obj.t{i} = obj.tm{i}.GetMean();
  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(obj.t{i});

  obj.dWdp{i} = obj.sm{i}.Compute_duvidp();
  
  obj.Jt{i} = obj.tm{i}.Compute_dtdp(dtdx,dtdy,obj.dWdp{i});
  
  %-----
  if obj.shape_reg ~= 0
    obj.sm{i}.inv_sigma_p0 = diag(1./[obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1:obj.sm{i}.n_b)]); 
    obj.sm{i}.sigma_p0 = diag([obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1:obj.sm{i}.n_b)]);
    obj.sm{i}.sigma_pk = zeros(size(obj.sm{i}.sigma_p0));
  end
  %-----
  
end

