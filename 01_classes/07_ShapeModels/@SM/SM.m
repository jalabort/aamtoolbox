classdef (Abstract) SM
  %SM Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    pca 
    
    mu
    pc
    ev 
    n_pc
    
    mu_ann
      
    n_q
    n_p
    n_qpr
    
    n_vert
  end
  
  methods
    function obj = SM(ann)
      obj.n_vert = size(ann,1);
    end
    
    ann = Shape2Ann(obj,shape)
    shape = Ann2Shape(obj,ann)
    [x,y] = Shape2XY(obj,shape)
    
    p = Shape2P(obj,shape)
    shape = P2Shape(obj,p)
    
    dxdq = Compute_dxdq(obj)
    dxdp = Compute_dxdp(obj)
    dxdr = Compute_dxdr(obj)
    dxdpr = Compute_dxdpr(obj)
    dxdqpr = Compute_dxdqpr(obj)
    
    dWdqpr = Compute_dWdqpr(obj,dw_dxy)
  end

  
end

