function [obj] = PreComputeDense(obj,i)
  %PreComputeDense Summary of this function goes here
  %   Detailed explanation goes here

  [dWudp,dWvdp] = obj.sm{i}.Shape2UV(obj.sm{i}.Compute_duvidp());
  obj.dWdp{i} = [dWudp(obj.w{i}.rf.n_vert+1:end,:); ...
    dWvdp(obj.w{i}.rf.n_vert+1:end,:)];
  
  %-----
  if obj.shape_reg ~= 0
    obj.w{i}.inv_sigma_p0 = diag(1./[obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1:obj.sm{i}.n_b)]); 
    obj.w{i}.sigma_p0 = diag([obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1:obj.sm{i}.n_b)]);
    obj.w{i}.sigma_pk = zeros(size(obj.w{i}.sigma_p0));
  end
  if obj.tex_reg ~= 0
    obj.tm{i}.inv_sigma_ck = obj.tm{i}.variance^2 * obj.tm{i}.pc(:,1:obj.tm{i}.n_c)' * obj.tm{i}.pc(:,1:obj.tm{i}.n_c);
    obj.tm{i}.inv_sigma_c0 = diag(1./obj.tm{i}.ev(1:obj.tm{i}.n_c));
  end
  %-----
  
end

