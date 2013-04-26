function [t] = ProjectOut(obj,t)
  %PROJECTOUT Summary of this function goes here
  %   Detailed explanation goes here

  t = t - obj.pc(:,2:obj.n_c) * (obj.pc(:,2:obj.n_c)' * t);

end

