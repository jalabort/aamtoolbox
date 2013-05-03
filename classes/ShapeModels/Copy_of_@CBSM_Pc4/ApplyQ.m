function [q_ann] = ApplyQ(obj,ann,A,t)
  %APPLYQ Summary of this function goes here
  %   Detailed explanation goes here

  q_ann = ann * A + repmat(t,[obj.n_vert,1]);

end

