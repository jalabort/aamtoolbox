classdef (Abstract) F_2D < M_2D
  %F_2D Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    detector
    n_it
  end
  
  methods
    function obj = F_2D(m)
      obj = obj@M_2D(m.sm,m.w,m.tm);
    end
    
    obj = InitializeDense(obj)
    obj = InitializeSparse(obj)
    fann = FitDense(obj,img,ann)
    fann = FitSparse(obj,img,ann)
    rann = Reconstruct(obj,ann)
  end
  
  methods (Abstract)
    obj = PreComputeSparse(obj,level)
    obj = PreComputeDense(obj,level)
    [delta,c] = Optimize(obj,i,j,tex,c,p)
    [ann,p] = UpdateDenseAnn(obj,i,ann,delta,p)
    [ann,p] = UpdateSparseAnn(obj,i,ann,delta,p)

  end
  
end

