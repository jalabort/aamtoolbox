classdef (Abstract) Interface_NWarp
  %INTERFACE_NWARP Summary of this class goes here
  %   Detailed explanation goes here
  
  methods        
    function obj = Interface_NWarp()
      [obj.sim_basis,obj.pc,obj.ev] = obj.OrthonormalizeBasis();
      obj.n_pc = size(obj.pc,2);
      obj.n_b = obj.n_pc;
      obj.n_p = obj.n_q + obj.n_b;
    end
    
    [sim_basis,pc,ev] = OrthonormalizeBasis(obj);

    b = Shape2B(obj,shape)
    shape = B2Shape(obj,b)
    
    q = Shape2Q(obj,shape)
    shape = Q2Shape(obj,q)
    
    [A,t] = ComputeSimilarityMatrixForm(obj,ann)
    [A,t] = Q2MatForm(obj,q)
    
    [ann] = ApplyQ(obj,q,shape)
    [ann] = RemoveQ(obj,q,shape)
  end
  
end

