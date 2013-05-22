classdef (Abstract) GSM_Euler < SM
  %GSM_Euler Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    mu
    pc
    ev 
    
    sim_mu
    sim_basis
    
    mu_ann
    
    alpha_pi
    
    n_pc
    n_sim_basis
    
    n_b
    n_q
  end
  
  methods
    function obj = GSM_Euler(ann,alpha)
      obj@SM(ann);
      
      % align annotations
      [obj.mu_ann,ann] = obj.AlignAnn(ann);
      
      % necessary for euler mapping
      k = max(ann(:)) - min(ann(:));
      obj.alpha_pi = alpha * pi / k;
      
      % transform annotations to shapes and compute pca
      shape = obj.Ann2Shape(ann);
      eshape = obj.Shape2EShape(shape);
      [obj.mu,obj.pc,obj.ev] = obj.pca.Compute(eshape);
      
      
      
      
     
      
      
      
      obj.mu_ann = obj.Shape2Ann(obj.EShape2Shape(obj.pc(:,1)));
      
%       eshape = obj.pc(:,1);
%       dir = angle(eshape(1:2*obj.n_vert) + 1j*eshape(2*obj.n_vert+1:end));
%       obj.mu_ann = obj.Shape2Ann(dir);
      
      
      
      
      
      
      
      
      
      
      
      % compute similarity basis
      [obj.sim_mu,obj.sim_basis] = obj.ComputeSimilarityBasis();
      
      % set static size properties
      obj.n_pc = size(obj.pc,2);
      obj.n_sim_basis = size(obj.sim_basis,2);
      
      % initialize dinamic size properties
      obj.n_q = obj.n_sim_basis;
      obj.n_b = obj.n_pc;
      obj.n_p = obj.n_q + obj.n_b;
    end

    duidq = Compute_duidq(obj)
    duidb = Compute_duidb(obj)
  end

  methods (Abstract)
    [mu,sim_basis] = ComputeSimilarityBasis(obj)
  end
  
end

