function [qpr_ann,q,p,r] = UpdateAnn(obj,sm,ann,delta,q,p,r,H)
  %UPDATEANN Summary of this function goes here
  %   Detailed explanation goes here
  
  vec_r = sm.VectorizeR(r);
  
%   [A,~] = sm.Q2MatForm(q);
%   pr = [p;vec_r];
%   pr_ann = sm.PR2Ann(pr);
%   [dw_dxpr] = sm.Ann2Shape(obj.ComputeDWDXYQPR(A,pr_ann));

  A = [1,0;0,1];
  [dw_dxpr] = sm.Ann2Shape(obj.ComputeDWDXYQPR(A,ann));
  
  dw_dpr0 = sm.GetDXYDQPR();   
  block_dw_dxqpr = repmat(dw_dxpr(:,1),[1,sm.n_qpr]);
  block_dw_dyqpr = repmat(dw_dxpr(:,2),[1,sm.n_qpr]); 
  dw_dx_x_dw_dqpr0 = dw_dpr0 .* block_dw_dxqpr + dw_dpr0 .* block_dw_dyqpr;
  
  aux = sm.GetDXYDPR();
  ds_dpr = A(1,1) * aux + A(2,1) * [-aux(1+obj.rf.n_vert:end,:);aux(1:obj.rf.n_vert,:)];   
  dw_dqpr = [sm.GetDXYDQ(),ds_dpr];
  
  jp = - (dw_dqpr' * dw_dqpr) \ dw_dqpr' * dw_dx_x_dw_dqpr0;
  
%   invcov1 = inv(sm.ComputeCovarianceMatrix());
%   invcov2 = inv(jp * H * jp');
%   invcov3 = inv(invcov1 + invcov2);
%   
%   qpr = invcov3 * invcov2 * ([q;p;vec_r] + jp * delta);

  qpr = [q;p;vec_r] + jp * delta;
   
  [qpr_ann,q,p,r] = sm.QPR2Ann(qpr);
  
end