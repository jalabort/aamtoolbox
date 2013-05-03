function [tex,aux] = C2Tex(obj,c)
  %C2TEX Summary of this function goes here
  %   Detailed explanation goes here

  tex = obj.pca.Coeff2Data(obj.mu,obj.pc(:,1:length(c)),c);
  aux = [];

end

