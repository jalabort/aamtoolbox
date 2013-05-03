function [dt_dc] = ComputeDTDC(obj,n_c,~,~)
  %COMPUTEDTDC Summary of this function goes here
  %   Detailed explanation goes here

  dt_dc = obj.pc(:,1:n_c);

end

