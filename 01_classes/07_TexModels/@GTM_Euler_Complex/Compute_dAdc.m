function [dAdc] = Compute_dAdc(obj)
  %Compute_dAdc Summary of this function goes here
  %   Detailed explanation goes here

  dAdc = obj.Compute_dAdc@GTM_Concat_Interface(obj);
  
  % complex derivative
  dAdrec = 0.5 * (real(dAdc) + 1i*imag(dAdc));
  dAdimc = 0.5 * (imag(dAdc) - 1i*real(dAdc));
  dAdc = dAdrec + dAdimc;

end

