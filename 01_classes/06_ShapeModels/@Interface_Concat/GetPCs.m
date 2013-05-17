function [pc] = GetPCs(obj)
  %GetPCs Summary of this function goes here
  %   Detailed explanation goes here
  
  pc = obj.pc(:,1:obj.n_b);
  
end

