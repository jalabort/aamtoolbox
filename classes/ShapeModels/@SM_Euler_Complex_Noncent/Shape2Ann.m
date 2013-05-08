function [ann] = Shape2Ann(obj,eShapes)
  %SHAPE2ANN Summary of this function goes here
  %   Detailed explanation goes here
  
  aux = imag(log(eShapes));
  aux = unwrap(aux,pi);
%   ind = aux < -pi;
%   aux(ind) = aux (ind) + 2*pi;
%   ind = aux > pi;
%   aux(ind) = aux (ind) - 2*pi;
%   ind = aux < (1.9 - 2) * pi / 2;
%   aux(ind) = aux(ind) + 2 * pi;

  aux = aux / obj.alphaPi;
  ann = reshape(aux,obj.nVert,2,[]);
  
end