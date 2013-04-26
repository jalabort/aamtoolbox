function [rsAnn] = RemoveSim(obj,ann,A,t)
  %REMOVESIM Summary of this function goes here
  %   Detailed explanation goes here

  rsAnn = (ann - repmat(t,[obj.nVert,1])) / A;

end

