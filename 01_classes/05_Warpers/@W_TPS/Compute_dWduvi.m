function [dWduvi] = Compute_dWduvi(obj)
  %Compute_dWduvi Summary of this function goes here
  %   Detailed explanation goes here

  rSize = size(obj.r);
  SSize = size(obj.S);
  LSize = size(obj.L);
  
  T = [obj.rf.tc;zeros(3,2)];
  
  dw_dx = zeros(obj.rf.n_face_pixels1,obj.rf.n_vert);
  dw_dy = zeros(obj.rf.n_face_pixels1,obj.rf.n_vert);
  
  for j = 1:obj.rf.n_vert
    
    mask2 = zeros(rSize);
    mask2(j,:) = 1;
    mask2(:,j) = -1;
    
    mask3 = mask2 == 0;
    
    aux = obj.r;
    aux = aux .* mask2;
    
    aux2 = obj.s;
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
    
    dL1_dx = - obj.L \ dL_dx / obj.L;
    dL1_dy = - obj.L \ dL_dy / obj.L;
  
    dO_dx = dL1_dx * T;
    dO_dy = dL1_dy * T;
    
    aux = zeros(obj.rf.res);
    aux2 = aux;
    
    aux(obj.rf.mask1) = obj.k * dO_dx(:,1);
    aux2(obj.rf.mask1) = obj.k * dO_dy(:,2);
  
    dw_dx(:,j) = aux(obj.rf.mask1);
    dw_dy(:,j) = aux2(obj.rf.mask1);
    
  end

  dWduvi = dw_dx;
  
end

