classdef (Abstract) SM
  %SM Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    pca 
    n_p    
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
    
    ann = P2Ann(obj,p)
    p = Ann2P(obj,ann)
    
    st = Ann2ST(obj,ann)
    ann = ST2Ann(obj,st)
    
    srt = Ann2SRT(obj,ann)
    ann = SRT2Ann(obj,srt)
    
    pann = ProjectAnn(obj,ann)
    
    dWdp = Compute_dWdp(obj,dWdxu)
    dWdp_uip = Compute_dWdp_uip(obj,A,ann)
  end

  
end

