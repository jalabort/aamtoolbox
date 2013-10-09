classdef (Abstract) iNWarp
  %iNWarp Summary of this class goes here
  %   Detailed explanation goes here
  
  methods     
    [sim_basis,pc,ev] = OrthonormalizeBasis(obj);

    b = Shape2B(obj,shape)
    shape = B2Shape(obj,b)
    
    q = Shape2Q(obj,shape)
    shape = Q2Shape(obj,q)
    
    [A,t] = ComputeSimilarityMatrixForm(obj,ann)
    [A,t] = Q2MatForm(obj,q)
    
    [ann] = ApplyQ(obj,q,shape)
    [shape] = ApplyB(obj,b,shape)
    [shape,ann] = RemoveQ(obj,q,shape)
  end
  
end

