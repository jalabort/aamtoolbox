classdef CBSM_Pc4
  %CBSM_PC4 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties 
    pca
    
    comp_mu
    comp_pc
    comp_ev
    n_comp_pc
    
    mass_mu
    mass_pc
    mass_ev
    n_mass_pc
    
    sim_mu
    sim_basis
    n_sim_basis
    
    i_comp_ann
    i_comp_shape
    
    mu_ann
    
    n_q
    n_p
    n_r
    n_qpr
    
    n_vert
    n_comp
  end
  
  methods
    function obj = CBSM_Pc4(ann,n_vert,n_ann,comp,n_comp)
      obj.pca = PCA_C();
      
      obj.i_comp_ann = comp;
      for i = 1:n_comp 
        obj.i_comp_shape{i} = [comp{i},n_vert+comp{i}];
      end
      
      obj.n_vert = n_vert;
      obj.n_comp = n_comp;
      
      [obj.mu_ann,mass_ann,comp_ann] = obj.AlignAnn(ann,n_ann);
      
      comp_shape = obj.Ann2Shape(comp_ann);
      for i = 1:n_comp
        [obj.comp_mu{i},obj.comp_pc{i},obj.comp_ev{i},obj.n_comp_pc{i}] = obj.pca.Compute(comp_shape(obj.i_comp_shape{i},:),n_ann);
        %[obj.comp_pc{i},obj.comp_ev{i},obj.n_comp_pc{i}] = obj.ComputeScaleBase(i);
      end
      
      mass_shape = obj.Ann2Shape(mass_ann);
      [obj.mass_mu,obj.mass_pc,obj.mass_ev,obj.n_mass_pc] = obj.pca.Compute(mass_shape,n_ann);
      
      [obj.sim_mu,obj.sim_basis,obj.n_sim_basis,obj.mass_pc] = obj.ComputeGlobalSimBasis(); 
      
      % -------------------------------------------------------------------
      
      obj.sim_mu = obj.Ann2Shape(obj.mu_ann);
      obj.mass_mu = obj.MassShape2Shape([obj.mass_mu]);
      aux = obj.MassShape2Shape([obj.sim_basis,obj.mass_pc]);
      [aux,~] = qr(aux,0);
      
      obj.sim_basis = aux(:,1:4);
      obj.mass_pc = aux(:,5:end);
      
      % -------------------------------------------------------------------
      
      obj.n_q = obj.n_sim_basis;
      obj.n_p = obj.n_mass_pc;
      obj.n_r = [obj.n_comp_pc{:}];
      obj.n_qpr = obj.n_q + obj.n_p + sum(obj.n_r);
    end
    
    [deafult_ann,mass_ann,comp_ann] = AlignAnn(obj,ann,n_ann)
    
    [comp_pc,comp_ev,n_comp_pc] = ComputeScaleBase(obj,i)
    
    [sim_mu,sim_pc,n_sim,t_pc] = ComputeGlobalSimBasis(obj)
    [A,t] = ComputeSimMatForm(obj,ann)
    
    ann = Shape2Ann(obj,shape)
    [x,y] = Shape2XY(obj,shape)
    
    shape = Ann2Shape(obj,ann)
   
    r = Shape2R(obj,shape)
    [shape] = R2Shape(obj,r)
    p = Shape2P(obj,shape)
    [shape] = P2Shape(obj,p)
    q = Shape2Q(obj,shape)
    [shape] = Q2Shape(obj,q)
    
    [qprAnn,q,p,r] = ProjectAnn(obj,ann)
    
    [qpr_ann] = PrepareComposition(obj,delta)
    
    [dx_dr,dy_dr] = ComputeDXYDR(obj)
    [dx_dp,dy_dp] = ComputeDXYDP(obj)
    [dx_dq,dy_dq] = ComputeDXYDQ(obj)
  end
  
end

