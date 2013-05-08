classdef SM_Euler_Complex < SM
  %SM_EULER_COMPLEX Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    simMU
    simBasis
    nSimDim
    nTotalDim
    alphaPi
  end
  
  methods
    function obj = SM_Euler_Complex(refAnn,aliAnn,nAnn,nVert,alpha)
      obj@SM(nVert);
      obj.pca = PCA_N();
      m = min(aliAnn(:));
      k = max(aliAnn(:)) - m;
      obj.alphaPi = alpha * pi / k;
      eShapes = obj.Ann2Shape(aliAnn);
      [obj.MU,obj.PC,obj.EV,obj.nDim] = obj.pca.Compute(eShapes,nAnn,'stefanos',1);
      obj.simMU = obj.Ann2SimShape(refAnn);
      [obj.simBasis,obj.nSimDim] = obj.ComputeGlobalSimBasis();
      obj.nTotalDim = obj.nDim + obj.nSimDim;
    end
    
    ann = SimShape2Ann(obj,sShape)
    sShape = Ann2SimShape(obj,ann)
    [x,y] = SimShape2XY(obj,sShape)
    
    [simBasis,nSimDim] = ComputeGlobalSimBasis(obj)
    [A,t] = ComputeSimMatForm(obj,ann)
    
    [coeff] = SimShape2Coeff(obj,sShape)
    [sShape] = Coeff2SimShape(obj,coeff)
    
    [pqAnn,q,p] = ProjectAnn(obj,ann,nShapes,reg,n)
    
    [dx_dq,dy_dq] = Compute_dxy_dq(obj)
  end
  
end

