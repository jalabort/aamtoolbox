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
      
    n_p
    n_qpr
    
    n_vert
  end
  
  methods
    function obj = SM(n_vert)
      obj.n_vert = n_vert;
    end
    
    ann = Shape2Ann(obj,shape)
    shape = Ann2Shape(obj,ann)
    [x,y] = Shape2XY(obj,shape)
    
    [p] = Shape2P(obj,shape)
    [shape] = P2Shape(obj,p)
    
    [dx_dp,dy_dp] = ComputeDXYDP(obj)
  end

  
end

