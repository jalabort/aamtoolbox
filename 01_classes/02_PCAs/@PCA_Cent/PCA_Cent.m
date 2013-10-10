classdef PCA_Cent < PCA
  %PCA_Cent Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Lp = false;
  end
  
  methods
    function obj = PCA_Cent(Lp)
      if nargin > 0
        obj.Lp = Lp;
      end
    end
    
    [mu,pc,ev] = Compute(obj,data)
  end
  
  methods (Static)
    cov = ComputeCovMatrix(data)
    [pc,ev] = ComputeFromCov(cov,cent_data)
    
    coeff = Data2Coeff(mu,pc,data)
    data = Coeff2Data(mu,pc,coeff)
  end
  
end

