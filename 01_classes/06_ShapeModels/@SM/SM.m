classdef (Abstract) SM
  %SM Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    n_p    
    n_vert
  end
  
  methods
    function obj = SM(ann)
      obj.n_vert = size(ann,1);
    end
    
    ann = P2Ann(obj,p)
    p = Ann2P(obj,ann)
    
    pann = ProjectAnn(obj,ann)
    
    [mu,cann] = AlignAnn(obj,ann)
    
    dWdp = Compute_dWdp(obj,dWduvi)
  end

  methods (Abstract)
    ann = Shape2Ann(obj,shape)
    shape = Ann2Shape(obj,ann)

    p = Shape2P(obj,shape)
    shape = P2Shape(obj,p)
    
    [u,v] = Shape2UV(obj,shape)
    [shape] = UV2Shape(obj,u,v)

    st = Ann2ST(obj,ann)
    srt = Ann2SRT(obj,ann)

    dWdp_uip = Compute_dWdp_uip(obj,A,ann)
  end

  
end

