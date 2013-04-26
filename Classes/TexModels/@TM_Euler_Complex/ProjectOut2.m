function [t] = ProjectOut2(obj,t)
  %PROJECTOUT2 Summary of this function goes here
  %   Detailed explanation goes here

  t = t - obj.pc(:,1:obj.n_c) * (obj.pc(:,1:obj.n_c)' * t);

end

