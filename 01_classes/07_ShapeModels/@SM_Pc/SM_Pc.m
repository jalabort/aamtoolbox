classdef (Abstract) SM_Pc < SM & SB
  %SM_Pc Summary of this class goes here
  %   Detailed explanation goes here
  
  properties

  end
  
  methods
    function obj = SM_Pc(ann)
      obj@SM(ann);
      
      % create pca object
      obj.pca = PCA_C();
      
      % align the annotations
      [obj.mu_ann,ann] = obj.AlignAnn(ann);
      
      % transform annotations to shapes and compute pca
      shape = obj.Ann2Shape(ann);
      [obj.mu,obj.pc,obj.ev] = obj.pca.Compute(shape);
      
      % compute similarity basis
      [obj.sim_mu,obj.sim_basis] = obj.ComputeGlobalSimBasis();
      
      % set
      obj.n_q = obj.n_sim_basis;
      obj.n_p = obj.n_pc;
      obj.n_qpr = obj.n_q + obj.n_p;
    end
    
    [deafult_ann,ann] = AlignAnn(obj,ann,n_ann)
    
    [mu,sim_basis,n_pc_basis] = ComputeGlobalSimBasis(obj)
    
    [qp_ann] = PrepareComposition(obj,delta)
  end
  
end

