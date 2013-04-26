classdef SM_Pc_Complex_2 < SM
  %SM_PC_COMPLEX Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    simMU
    simBasis
    nSimDim
    nTotalDim
  end
  
  methods
    function obj = SM_Pc_Complex_2(rAnn,aliAnn,nAnn,nVert)
      obj@SM(nVert);
      obj.pca = CPCA_WLM();
      shapes = obj.Ann2Shape(aliAnn);
      [obj.MU,obj.PC,obj.EV,obj.nDim] = obj.pca.Compute(shapes,nAnn);
      [obj.simMU,obj.simBasis,obj.nSimDim,obj.PC] = obj.ComputeGlobalSimBasis(rAnn);
      obj.nTotalDim = obj.nDim + obj.nSimDim;
    end
    
    ann = SimShape2Ann(obj,sShape)
    sShape = Ann2SimShape(obj,ann)
    [x,y] = SimShape2XY(obj,sShape)
    
    [simBasis,nSimDim,PC,nDim] = ComputeGlobalSimBasis(obj,rAnn)
    [A,t] = ComputeSimMatForm(obj,ann)
    
    [q] = SimShape2Q(obj,sShape)
    [sShape] = Q2SimShape(obj,q)
    
    [dx_dq,dy_dq] = Compute_dxy_dq(obj)
  end
  
end

