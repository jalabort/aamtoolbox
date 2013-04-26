classdef SM_Pc3 < SM
  %SM_PC Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    sim_mu
    sim_basis
    n_sim_basis
    
    n_q
    
    i_comp_ann
    i_comp_shape
    
    n_comp
  end
  
  methods
    function obj = SM_Pc3(ann,n_vert,n_ann,comp,n_comp)
      obj@SM(n_vert);
      
      obj.i_comp_ann = comp;
      for i = 1:n_comp 
        obj.i_comp_shape{i} = [comp{i},n_vert+comp{i}];
      end
      
      obj.n_vert = n_vert;
      obj.n_comp = n_comp;
      
      
      %--------------------------------------------------------------------
      
      obj.pca = PCA_C();
      
      n = 2;
      
      [obj.mu_ann,ann] = obj.AlignAnnHack(ann,n_ann);
      
      shape = obj.Ann2Shape(ann);
      [obj.mu,pose_pc,ev,~] = obj.pca.Compute(shape,n_ann);
      sigma_pose = pose_pc(:,1:n) * diag(ev(1:n)) * pose_pc(:,1:n)';
      
      po_shape = shape - pose_pc(:,1:n) * (pose_pc(:,1:n)' * shape);
      po_ann = obj.Shape2Ann(po_shape);
      
      
      %--------------------------------------------------------------------
      
     
      [obj.mu_ann,mass_ann,comp_ann] = obj.AlignAnn(po_ann,n_ann);
      
      mass_shape = obj.Ann2Shape(mass_ann);
      [sigma_mass] = obj.pca.ComputeCovMatrix(mass_shape,n_ann);
      
      sigma_comp = cell(1,n_comp);
      comp_shape = obj.Ann2Shape(comp_ann);
      for i = 1:n_comp
        [sigma_comp{i}] = obj.pca.ComputeCovMatrix(comp_shape(obj.i_comp_shape{i},:),n_ann);
      end
      
      s = 1; 
      for i = 1:n_comp
        mat(obj.i_comp_shape{i},obj.i_comp_shape{i}) = sigma_comp{i};
      end
      
      
      % -------------------------------------------------------------------
      
      
      sigma_all = sigma_pose + sigma_mass + mat;
      [obj.pc,obj.ev,obj.n_pc] = obj.pca.ComputeFromCov(sigma_all,n_ann);
      
      
      % -------------------------------------------------------------------
      
      [obj.sim_mu,obj.sim_basis,obj.n_sim_basis,obj.pc] = obj.ComputeGlobalSimBasis();
      
      obj.n_q = obj.n_sim_basis;
      obj.n_p = obj.n_pc;
      obj.n_qpr = obj.n_q + obj.n_p;
    end
    
    [mu,sim_basis,n_pc_basis,pc] = ComputeGlobalSimBasis(obj)
    [A,t] = ComputeSimMatForm(obj,ann)
    
    [q] = Shape2Q(obj,shape)
    [shape] = Q2Shape(obj,q)
    
    [qprAnn,q,p,r] = ProjectAnn(obj,ann)
    
    [qp_ann] = PrepareComposition(obj,delta)
    
    [dx_dq,dy_dq] = ComputeDXYDQ(obj)
  end
  
end

