function [dT_dc] = Compute_dT_dc(obj,nTex,~,~)
  %COMPUTE_DT_DC Summary of this function goes here
  %   Detailed explanation goes here

  dT_dc = obj.PC(:,1:nTex); 
  dT_dc = 0.5 * (real(dT_dc) + 1i*imag(dT_dc) + imag(dT_dc) - 1i*real(dT_dc));

end

