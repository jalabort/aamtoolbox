function [tri_base] = ComputeTriBase(obj)
  %COMPUTETRIBASE Summary of this function goes here
  %   Detailed explanation goes here
  
  tri_base = zeros(obj.rf.res);

  for i = 1:obj.n_tri
    x = obj.rf.tc(obj.tri(i,:),1);
    y = obj.rf.tc(obj.tri(i,:),2);
    base = poly2mask(x,y,obj.rf.res(1),obj.rf.res(2)) .* i;
    tri_base = max(tri_base,base);
  end

end

