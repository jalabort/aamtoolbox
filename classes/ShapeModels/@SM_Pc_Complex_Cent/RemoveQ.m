function [p_ann] = RemoveQ(obj,ann,A,t)
  %REMOVEQ Summary of this function goes here
  %   Detailed explanation goes here

  p_ann = (ann - repmat(t,[obj.n_vert,1])) / A;

end

