function [tex] = C2Tex(obj,c)
  %C2Tex Summary of this function goes here
  %   Detailed explanation goes here

  tex = obj.pca.Coeff2Data(obj.mu,obj.pc(:,1:obj.n_c),c);
  
end

