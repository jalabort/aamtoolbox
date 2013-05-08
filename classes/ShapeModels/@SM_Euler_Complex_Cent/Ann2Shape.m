function [eShape] = Ann2Shape(obj,ann)
  %ANN2SHAPE Summary of this function goes here
  %   Detailed explanation goes here
  
  nVert2 = 2*obj.nVert;
  aux = reshape(ann,nVert2,[]);
  
%   m = repmat(min(aux),[nVert2,1]);
%   k = repmat(max(aux),[nVert2,1]) - m;
%   aux(aux<0.01) = 0.01;
%   aux(aux>0.99) = 0.99;
  aux = unwrap(obj.alphaPi * aux);
  eShape = exp(1i*aux);

end

