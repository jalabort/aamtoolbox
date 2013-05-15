classdef (Abstract) GSM < SM
  %GSM Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    mu
    pc
    ev 
    
    sim_mu
    sim_basis
    
    mu_ann
    
    n_pc
    n_sim_basis
    
    n_b
    n_q
  end
  
  methods
    function obj = GSM(ann)
      obj@SM(ann);
      
      % create pca object
      obj.pca = PCA_Cent();
      
      % align the annotations
      [obj.mu_ann,ann] = obj.AlignAnn(ann);
      
      % transform annotations to shapes and compute pca
      shape = obj.Ann2Shape(ann);
      [obj.mu,obj.pc,obj.ev] = obj.pca.Compute(shape);
      
      % compute similarity basis
      [obj.sim_mu,obj.sim_basis] = obj.ComputeSimilarityBasis();
      
      % set static size properties
      obj.n_pc = size(obj.pc,2);
      obj.n_sim_basis = size(obj.sim_basis,2);
      
      % set dinamic size properties
      obj.n_q = obj.n_sim_basis;
      obj.n_b = obj.n_pc;
      obj.n_p = obj.n_q + obj.n_b;
    end

    [mu,cann] = AlignAnn(obj,ann)

    [duidq] = Compute_duidq(obj)
    [duidb] = Compute_duidb(obj)
  end

  methods (Abstract)
    [mu,sim_basis] = ComputeSimilarityBasis(obj)
  end
  
end

