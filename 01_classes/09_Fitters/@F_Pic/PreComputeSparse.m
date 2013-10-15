function [obj] = PreComputeSparse(obj,i)
  %PreComputeSparse Summary of this function goes here
  %   Detailed explanation goes here
  
  obj.t{i} = obj.tm{i}.GetMean();
  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(obj.t{i});

  dWduvi = obj.w{i}.Compute_dWduvi();
  dWdp = obj.sm{i}.Compute_dWdp(dWduvi);
  
  J = obj.tm{i}.Compute_dtdp(dtdx,dtdy,dWdp);
  J2 = obj.tm{i}.ProjectOut(J);
  obj.J{i} = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J));
  J2 = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J2));
  
  obj.invH{i} = inv(J2' * obj.J{i});
  
  %-----
  if obj.shape_reg ~= 0
    obj.sm{i}.sigma_inv_p = obj.tm{i}.variance^2 * obj.invH{i};
    obj.sm{i}.inv_sigma_p0 = diag(1./[obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1:obj.sm{i}.n_b)]); 
    obj.sm{i}.sigma_p0 = diag([obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1),obj.sm{i}.ev(1:obj.sm{i}.n_b)]);
    obj.sm{i}.sigma_pk = zeros(size(obj.sm{i}.sigma_p0));
  end
  %-----
  
end

