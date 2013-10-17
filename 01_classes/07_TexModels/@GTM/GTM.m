classdef (Abstract) GTM < TM
  %GTM Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    mu
    pc
    ev
    
    n_pc
    
    variance
  end
  
  methods
    function obj = GTM(img,rf,Lp)
      obj@TM(rf);
      
      % number of features
      obj.n_ch = size(img,3);
      
      % convert images to textures (vectors)
      tex = obj.TransformAll(img);
      
      % compute pca
      obj.pca.Lp = Lp;
      [obj.mu,obj.pc,obj.ev] = obj.pca.Compute(tex);
      obj.n_pc = size(obj.pc,2);
      
      % initialize dinamic size properties
      obj.n_c = obj.n_pc;
      
      % set discarted variance to 0
      obj.variance = 0;
    end
    
    variance = ComputeLeftOutVariance(obj)
    [n_c,variance] = SetNC(obj,n_c)
  end
  
  methods (Abstract) 
    tex = Transform(obj,img)
    t = GetMean(obj)
    t = ProjectOut(obj,t)
    t = Compute_DtS(obj,t)
    t = Compute_DwS(obj,t)
  end
  
end

