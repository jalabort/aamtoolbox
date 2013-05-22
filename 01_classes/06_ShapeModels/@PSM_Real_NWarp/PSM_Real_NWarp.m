classdef PSM_Real_NWarp < PSM_Real & iNWarp
  %PSM_Real_NWarp Summary of this class goes here
  %   Detailed explanation goes here
  
  methods
    function obj = PSM_Real_NWarp(ann,part)
      obj@PSM_Real(ann,part);
      [obj.sim_basis,obj.pose_pc,obj.pose_ev] = obj.OrthonormalizeBasis();
      obj.n_pose_pc = size(obj.pose_pc,2);
      
      obj.n_l = obj.n_pose_pc;
      obj.n_b = obj.n_l + obj.n_f + sum(obj.n_r);
      obj.n_p = obj.n_q + obj.n_b;
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

