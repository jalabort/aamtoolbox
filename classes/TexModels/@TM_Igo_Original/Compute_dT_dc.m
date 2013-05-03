function [dT_dc] = Compute_dT_dc(obj,nTexs,t,tt)
  %COMPUTE_DT_DC Summary of this function goes here
  %   Detailed explanation goes here

  dT_dc = zeros(obj.nCh*obj.nFacePixels,nTexs);
  
  for ch = 1:2:obj.nCh
    Ax = repmat(obj.getTexCh(tt,ch),1,nTexs);
    Ay = repmat(obj.getTexCh(tt,ch+1),1,nTexs);
    num = obj.getTexCh(obj.PC(:,1:nTexs),ch+1) .* Ax - Ay .* obj.getTexCh(obj.PC(:,1:nTexs),ch);
    den = repmat(obj.getTexCh(tt,ch).^2 + obj.getTexCh(tt,ch+1).^2,1,nTexs);
    aux = num ./ den;
    Ux = repmat(obj.getTexCh(t,ch+1),1,nTexs);
    Uy = repmat(obj.getTexCh(t,ch),1,nTexs);
    dTx_dc = - Ux .* aux; 
    dTy_dc = Uy .* aux;
    dT_dc((ch-1)*obj.nFacePixels+1:(ch+1)*obj.nFacePixels,:) = [dTx_dc;dTy_dc];
  end

end

