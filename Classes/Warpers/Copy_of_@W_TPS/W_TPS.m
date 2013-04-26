classdef W_TPS < W
  %W_TPS Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    pos
    S
    L
  end
  
  methods
    function obj = W_TPS(refFrame,interp)
      obj = obj@W(refFrame,interp);
      [obj.pos(:,2),obj.pos(:,1)] = find(obj.refFrame.mask2 == true);
      obj.S = [ones(refFrame.nVert,1),refFrame.tc];
      obj.L = zeros(refFrame.nVert+3);
      obj.L(1:end-3,end-2:end) = obj.S;
      obj.L(end-2:end,1:end-3) = obj.S';
    end
    
    W = GetWeights(obj,ann);
    warpedImg = WarpOpt(obj,ann,img,~)
    warpedImg = Warp1ChOpt(obj,ann,img)
    
    dW_dxy = Compute_dW_dxy(obj);
    dW_dp = Compute_dW_dp(obj,ann,A)
    
    [A,t] = ComputeSimMatForm(obj,shape,shapeMU)
    dW_dxyp = Compute_dW_dxyp(obj,ann,A);
    [fShape,q,p] = UpdateShape(obj,shapeModel,shape,rhos,alphas,delta,nShapes,tShapes)
  end

end

