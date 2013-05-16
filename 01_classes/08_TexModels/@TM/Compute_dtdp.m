function [dtdp] = Compute_dtdp(obj,dtdx,dtdy,dWdp)
  %Compute_dtdp Summary of this function goes here
  %   Detailed explanation goes here
  
  n_p = size(dWdp,2);

  dWxdp = obj.getTexCh(dWdp,1);
  dWydp = obj.getTexCh(dWdp,2);
  
  dtdp = zeros(obj.n_ch*obj.n_face_pixels,n_p);
  
  for i = 1:obj.n_ch
    ax = obj.getTexCh(dtdx,i);
    ay = obj.getTexCh(dtdy,i);
    ax = repmat(ax,1,p);
    ay = repmat(ay,1,p);
    dtdp((i-1)*obj.n_face_pixels+1:i*obj.n_face_pixels,:) = ... 
      ax .* dWxdp + ay .* dWydp;
  end

end

