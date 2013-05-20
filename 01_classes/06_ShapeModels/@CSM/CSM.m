classdef (Abstract) CSM < SM
  %CSM Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    part_mu
    part_pc
    part_ev 
    
    mass_mu
    mass_pc
    mass_ev
    
    sim_mu
    sim_basis
    
    mu_ann
    
    i_part_ann
    i_part_shape
    
    n_part
    
    n_part_pc
    n_mass_pc
    n_sim_basis
    
    n_r
    n_f
    n_b
    n_q
  end
  
  methods
    function obj = CSM(ann,part)
      obj@SM(ann);
      obj.n_part = length(part);
      
      % create pca object
      obj.pca = PCA_Cent();
      
      % compute parts indexes 
      obj.i_part_ann = part;
      obj.i_part_shape = obj.ComputeShapePartIndexes();
      
      % get mean annotation and align mass and part annotations
      [mass_ann,part_ann,obj.mu_ann] = obj.AlignMassAndPartsAnn(ann);
      
      % compute similarity basis
      [obj.sim_mu,obj.sim_basis] = obj.ComputeSimilarityBasis();
      
      % transform mass annotations to mass shapes and compute mass pca
      mass_shape = obj.Ann2Shape(mass_ann);
      [obj.mass_mu,obj.mass_pc,obj.mass_ev] = obj.pca.Compute(mass_shape);
      
      % transform parts annotations to parts shapes and compute parts pca
      part_shape = obj.Ann2Shape(part_ann);
      for i = 1:obj.n_part
        [obj.part_mu{i},obj.part_pc{i},obj.part_ev{i}] = ...
          obj.pca.Compute(part_shape(obj.i_part_shape{i},:));
        
        obj.n_part_pc{i} = size(obj.part_pc{i},2);
      end
      
      % set remaining static size properties
      obj.n_sim_basis = size(obj.sim_basis,2);
      obj.n_mass_pc = size(obj.mass_pc,2);
      
      % initialize dinamic size properties
      obj.n_q = obj.n_sim_basis;
      obj.n_f = obj.n_mass_pc;
      obj.n_r = [obj.n_part_pc{:}];
      obj.n_b = obj.n_f + sum(obj.n_r);
      obj.n_p = obj.n_q + obj.n_b;
    end

    [mass_ann,parts_ann,mu_ann] = obj.AlignMassAndPartsAnn(obj,ann)
    
    [n_b,n_p] = SetNB(obj,n_b)
    [n_r,n_p] = SetNR(obj,n_r)
    
    duidq = Compute_duidq(obj)
    duidb = Compute_duidb(obj)
    duidr = Compute_duidr(obj)
  end

  methods (Abstract)
    i_part_shape = ComputeShapePartIndexes(obj)
    
    [mu,sim_basis] = ComputeSimilarityBasis(obj)
    
    parts_pc_matrix = GetPartPCsMatrixForm(obj)
  end
  
end

