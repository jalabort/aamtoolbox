classdef SM_Pc2 < SM
  %SM_PC2 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    sim_mu
    sim_basis
    n_sim_basis
    
    n_q
    
    P
  end
  
  methods
    function obj = SM_Pc2(ann,n_vert,n_ann)
      obj@SM(n_vert);
      
      obj.pca = PCA_C();
      
      [obj.mu_ann,ann] = obj.AlignAnn(ann,n_ann);
      
      shape = obj.Ann2Shape(ann);
      [obj.mu,obj.pc,obj.ev,obj.n_pc] = obj.pca.Compute(shape,n_ann);
      
      [obj.sim_mu,obj.sim_basis,obj.n_sim_basis] = obj.ComputeGlobalSimBasis();
      
      obj.n_q = obj.n_sim_basis;
      obj.n_p = obj.n_pc;
      obj.n_qpr = obj.n_q + obj.n_p;
    end
    
    [deafult_ann,ann] = AlignAnn(obj,ann,n_ann)
    
    [mu,sim_basis,n_pc_basis,pc] = ComputeGlobalSimBasis(obj)
    [A,t] = ComputeSimMatForm(obj,ann)
    
    q = Shape2Q(obj,shape)
    shape = Q2Shape(obj,q)
    
    P = ComputeProjector(obj)
    
    [qprAnn,q,p,r] = ProjectAnn(obj,ann)
    
    qp_ann = PrepareComposition(obj,delta)
    
    [dx_dq,dy_dq] = ComputeDXYDQ(obj)
  end
  
end

