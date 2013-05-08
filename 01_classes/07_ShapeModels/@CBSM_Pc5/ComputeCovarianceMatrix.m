function [cov] = ComputeCovarianceMatrix(obj)
  %COMPUTECOVARIANCEMATRIX Summary of this function goes here
  %   Detailed explanation goes here
  
  sum_n_r = sum(obj.n_r);
  comp_ev = zeros(1,sum_n_r);
  
  if sum_n_r > 0
    s = 1; 
    for i = 1:obj.n_comp
      e = sum(obj.n_r(1:i));
      comp_ev(s:e) = obj.comp_ev{i}(1:obj.n_r(i));
      s = e + 1;
    end
  end
    
  v = [ones(1,obj.n_q),obj.mass_ev(1:obj.n_p),comp_ev];
  cov = diag(v);
  
end

