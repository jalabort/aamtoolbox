function [qpAnn,q,p] = UpdateAnn(obj,shapeModel,~,q,p,delta,nShapes,tShapes)
  %UPDATEANN Summary of this function goes here
  %   Detailed explanation goes here
  
  nSimBasis = tShapes - nShapes;
  
  [A,~] = shapeModel.Q2MatForm(q);
  pShape = shapeModel.P2Shape(p);
  pAnn = shapeModel.Shape2Ann(pShape);
  
  [dW_dxyp] = shapeModel.Ann2Shape(obj.Compute_dW_dxyp(pAnn,A));
  
  dW_dp0 = [shapeModel.simBasis,shapeModel.PC(:,1:nShapes)];   
  block_dW_dxp = repmat(dW_dxyp(:,1),[1,nSimBasis+nShapes]);
  block_dW_dyp = repmat(dW_dxyp(:,2),[1,nSimBasis+nShapes]); 
  dW_dx_x_dW_dp0 = dW_dp0 .* block_dW_dxp + dW_dp0 .* block_dW_dyp;
  
  aux = shapeModel.Shape2Ann(shapeModel.PC(:,1:nShapes));
  rotShapePC = zeros(shapeModel.nVert,nShapes);
  for i = 1:nShapes
    rotShapePC(:,i) = shapeModel.Ann2Shape(aux(:,:,i) * A);
  end
%   rotShapePC = (1+rhos(1)) * shapeModel.PC(:,1:nShapes) + rhos(2) * [-shapeModel.PC(1+obj.refFrame.nVert:end,1:nShapes); shapeModel.PC(1:obj.refFrame.nVert,1:nShapes)]; 
  dW_dp = [shapeModel.simBasis,rotShapePC];
  
  Jp = - (dW_dp' * dW_dp) \ dW_dp' * dW_dx_x_dW_dp0;
  
  qp = [q;p] + Jp * delta;
  q = qp(1:shapeModel.nSimDim);
  p = qp(shapeModel.nSimDim+1:end);
  
  [A,t] = shapeModel.Q2MatForm(q);
  pShape = shapeModel.P2Shape(p);
  pAnn = shapeModel.Shape2Ann(pShape);
  qpAnn = shapeModel.ApplySim(pAnn,A,t);
  
end