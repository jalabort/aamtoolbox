function [P,basis] = ComputeProjector(obj)
  %COMPUTEPROJECTOR Summary of this function goes here
  %   Detailed explanation goes here
  
  s = 0;
  comp_pc = zeros(obj.n_vert,sum(obj.n_r));
  for i = 1:obj.n_comp
    if obj.n_r(i) > 0
      comp_pc(obj.i_comp_shape{i},s+1:s+obj.n_r(i)) = obj.comp_pc{i}(:,1:obj.n_r(i));
      s = s + obj.n_r(i);
    end
  end

  basis = [obj.sim_basis,obj.mass_pc(:,1:obj.n_p),comp_pc];
  P = (basis' * basis) \ basis';
  
end



