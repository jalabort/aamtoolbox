function [dtdp] = Compute_dtdp(obj,dtdx,dtdy,dWdp)
  %Compute_dtdp Summary of this function goes here
  %   Detailed explanation goes here
  
  n_p = size(dWdp,2);

  dWxdp = obj.GetTexCh(dWdp,1);
  dWydp = obj.GetTexCh(dWdp,2);
  
  dtdp = zeros(obj.n_ch*obj.n_face_pixels1,n_p);
  
  for i = 1:obj.n_ch
    ax = obj.getTexCh(dtdx,i);
    ay = obj.getTexCh(dtdy,i);
    ax = repmat(ax,1,n_p);
    ay = repmat(ay,1,n_p);
    dtdp((i-1)*obj.n_face_pixels1+1:i*obj.n_face_pixels1,:) = ... 
      ax .* dWxdp + ay .* dWydp;
  end

end

