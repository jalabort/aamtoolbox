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
    
    [ann,p] = ProjectAnn(obj,ann)
    
    [mu,ann] = AlignAnn(obj,ann)
    
    dWdp = Compute_dWdp(obj,dWduvi)
    
    Save(obj,opt,i)
  end
  
  methods (Static)
    [obj,loaded] = Load(opt,i)
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

    dWdp_uip = Compute_duvidp_uvip(obj,A,ann)
  end

  
end

