function [t] = ProjectOut(obj,t)
  %PROJECTOUT Summary of this function goes here
  %   Detailed explanation goes here

  t = t - obj.A(:,1:obj.n_c) * (obj.A(:,1:obj.n_c)' * t);

end