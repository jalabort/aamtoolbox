function [dt_dp] = ComputeDTDQPR(obj,n_qpr,tx,ty,dw_dp,~,~)
  %COMPUTEDTDQPR Summary of this function goes here
  %   Detailed explanation goes here

  dwx_dp = obj.getTexCh(dw_dp,1);
  dwy_dp = obj.getTexCh(dw_dp,2);
  
  dt_dp = zeros(obj.n_ch*obj.n_face_pixels,n_qpr);
  
  for i = 1:obj.n_bin
    ax = obj.getTexCh(tx,i);
    ay = obj.getTexCh(ty,i);
    ax = repmat(ax,1,n_qpr);
    ay = repmat(ay,1,n_qpr);
    dt_dp((i-1)*obj.n_face_pixels+1:i*obj.n_face_pixels,:) = ax .* dwx_dp + ay .* dwy_dp;
  end

end

