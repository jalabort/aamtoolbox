function [dT_dp] = Compute_dT_dp(obj,nShapes,tx,ty,dW_dp,t,tt)
  %COMPUTE_dT_dp Summary of this function goes here
  %   Detailed explanation goes here

  igo_dT_dp = Compute_dT_dp@IgoTexModel(obj,nShapes,tx,ty,dW_dp);

  dT_dp = zeros(size(igo_dT_dp));
  
  for ch = 1:2:obj.nCh
    Ax = repmat(obj.getTexCh(tt,ch),1,nShapes);
    Ay = repmat(obj.getTexCh(tt,ch+1),1,nShapes);
    num = obj.getTexCh(igo_dT_dp,ch+1) .* Ax - Ay .* obj.getTexCh(igo_dT_dp,ch);
    den = repmat(sqrt(obj.getTexCh(tt,ch).^2 + obj.getTexCh(tt,ch+1).^2),1,nShapes);
    aux = num ./ den;
    Ux = repmat(obj.getTexCh(t,ch+1),1,nShapes);
    Uy = repmat(obj.getTexCh(t,ch),1,nShapes);
    dTx_dc = - Ux .* aux; 
    dTy_dc = Uy .* aux;
    dT_dp((ch-1)*obj.nFacePixels+1:(ch+1)*obj.nFacePixels,:) = [dTx_dc;dTy_dc];
  end

end

