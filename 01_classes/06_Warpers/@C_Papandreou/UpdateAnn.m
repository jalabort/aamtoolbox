function [qpr_ann,q,p,r] = UpdateAnn(obj,sm,ann,delta,q,p,r)
  %UPDATEANN Summary of this function goes here
  %   Detailed explanation goes here
  
  vec_r = sm.VectorizeR(r);
  dxdqpr = sm.Compute_dxdqpr();  
  
  if sm.has_nwarp
    % if warp defined as N(x;q) o W(x;p,r)
    [A,~] = sm.Q2MatForm(q);
    
    dxdpr = sm.Compute_dxdpr();
    dsdpr = A(1,1) * dxdpr + A(2,1) *  ...
      [-dxdpr(1+obj.rf.n_vert:end,:);dxdpr(1:obj.rf.n_vert,:)];   
    dWdqpr = [sm.Compute_dxdq(),dsdpr];
  else
    % warp defined as W(x;q,p,r)
    A = [1,0;0,1];
    
    dWdqpr = dxdqpr;
  end
  
  dWdui_qpr = sm.Ann2Shape(obj.Compute_dWdu_qpr(A,ann));
   
  block_dWdu_qpr = repmat(dWdui_qpr(:,1),[1,sm.n_qpr]);
  block_dWdv_qpr = repmat(dWdui_qpr(:,2),[1,sm.n_qpr]); 
  dWdx_x_dWdqpr_0 = dxdqpr .* block_dWdu_qpr + dxdqpr .* block_dWdv_qpr;
   
  Jp = - (dWdqpr' * dWdqpr) \ dWdqpr' * dWdx_x_dWdqpr_0;
  
  qpr = [q;p;vec_r] + Jp * delta;
  
  [qpr_ann,q,p,r] = sm.QPR2Ann(qpr);
  
end