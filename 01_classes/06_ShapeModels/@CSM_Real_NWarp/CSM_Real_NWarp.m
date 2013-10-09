classdef CSM_Real_NWarp < CSM_Real & iNWarp
  %CSM_Real_NWarp Summary of this class goes here
  %   Detailed explanation goes here
  
  methods
    function obj = CSM_Real_NWarp(ann,part)
      obj@CSM_Real(ann,part);
      [obj.sim_basis] = obj.OrthonormalizeBasis();
    end
    
    shape = obj.R2Shape(r);
    r = obj.Shape2R(shape);
    
    shape = obj.F2Shape(f);
    f = obj.Shape2F(shape);
    
    shape = obj.ApplyF(f,shape);
    shape = obj.RemoveF(f,shape);
    
    shape = obj.ApplyL(l,shape);
    shape = obj.RemoveL(l,shape);
  end
  
end

