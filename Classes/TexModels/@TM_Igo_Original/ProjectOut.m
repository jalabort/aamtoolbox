function [t] = ProjectOut(obj,t,nTexs)
  %PROJECTOUT Summary of this function goes here
  %   Detailed explanation goes here

  t = t - obj.PC(:,2:nTexs) * (obj.PC(:,2:nTexs)' * t);

end

