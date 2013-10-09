function [shape] = EShape2Shape(obj,eshape)
  %EShape2Shape Summary of this function goes here
  %   Detailed explanation goes here
    
  dir = angle(eshape(1:2*obj.n_vert) + 1j*eshape(2*obj.n_vert+1:end));
  shape = dir / obj.alpha_pi;

end

