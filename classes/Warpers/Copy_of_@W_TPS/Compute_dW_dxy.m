function [dW_dxy] = Compute_dW_dxy(obj)
  %COMPUTE_DW_DXY Summary of this function goes here
  %   Detailed explanation goes here
  
  r = zeros(obj.refFrame.nFacePixels2,obj.refFrame.nVert);
  for v = 1:obj.refFrame.nVert
    r(:,v) = sqrt(sum((obj.pos - repmat(obj.refFrame.tc(v,:),[obj.refFrame.nFacePixels2,1])).^2,2));
  end
  k = [r.^2 .* log(r.^2),ones(obj.refFrame.nFacePixels2,1),obj.pos(:,1),obj.pos(:,2)];
  
  s = zeros(obj.refFrame.nVert,obj.refFrame.nVert,2);
  r = zeros(obj.refFrame.nVert,obj.refFrame.nVert);
  for j = 1:obj.refFrame.nVert
    s(:,j,:) = obj.refFrame.tc - repmat(obj.refFrame.tc(j,:),[obj.refFrame.nVert,1]);
    r(:,j) = sqrt(sum(squeeze(s(:,j,:)).^2,2));
  end
  
  mask = r == 0;
  K = r.^2 .* log(r.^2);
  K(mask) = 0;
  obj.L(1:end-3,1:end-3) = K;
  
  rSize = size(r);
  SSize = size(obj.S);
  LSize = size(obj.L);
  
  T = [obj.refFrame.tc; zeros(3,2)];
  TSize = size(T);
  
  dW_dx = zeros(obj.refFrame.nFacePixels,obj.refFrame.nVert);
  dW_dy = zeros(obj.refFrame.nFacePixels,obj.refFrame.nVert);
  
  for j = 1:obj.refFrame.nVert
    
    mask2 = zeros(rSize);
    mask2(j,:) = 1;
    mask2(:,j) = -1;
    
    mask3 = mask2 == 0;
    
    aux = r;
    aux = aux .* mask2;
    
    aux2 = s;
    aux2(:,:,1) = aux2(:,:,1) .* mask2;
    aux2(:,:,2) = aux2(:,:,2) .* mask2;
    
    dK_dx = 2 * (1 + log(aux.^2)) .* aux2(:,:,1);
    dK_dx(mask3) = 0;
    dK_dx(j,j) = 0;
    dK_dy = 2 * (1 + log(aux.^2)) .* aux2(:,:,2);
    dK_dy(mask3) = 0;
    dK_dy(j,j) = 0;
    
    dS_dx = zeros(SSize);
    dS_dx(j,2) = -1;
    dS_dy = zeros(SSize);
    dS_dy(j,3) = -1;
    
    dL_dx = zeros(LSize);
    dL_dx(1:end-3,end-2:end) = dS_dx;
    dL_dx(end-2:end,1:end-3) = dS_dx';
    dL_dx(1:end-3,1:end-3) = dK_dx; 
    dL_dy = zeros(LSize);
    dL_dy(1:end-3,end-2:end) = dS_dy;
    dL_dy(end-2:end,1:end-3) = dS_dy';
    dL_dy(1:end-3,1:end-3) = dK_dy;
    
%     dT_dx = zeros(TSize);
%     dT_dx(j,1) = 1;
%     dT_dy = zeros(TSize);
%     dT_dy(j,2) = 1;
    
    dL1_dx = - obj.L \ dL_dx / obj.L;
    dL1_dy = - obj.L \ dL_dy / obj.L;
  
    dO_dx = dL1_dx * T;
    dO_dy = dL1_dy * T;
%     dO_dx = obj.L \ dT_dx;
%     dO_dy = obj.L \ dT_dy;
    
    aux = zeros(obj.refFrame.res);
    aux2 = aux;
    
    aux(obj.refFrame.mask2) = k * dO_dx(:,1);
    aux2(obj.refFrame.mask2) = k * dO_dy(:,2);
  
    dW_dx(:,j) = aux(obj.refFrame.mask);
    dW_dy(:,j) = aux2(obj.refFrame.mask);
    
  end

  dW_dxy = dW_dx;
  
end

