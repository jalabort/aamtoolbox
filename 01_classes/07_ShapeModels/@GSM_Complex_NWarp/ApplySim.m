function [qAnn] = ApplySim(obj,ann,A,t)
  %APPLYSIM Summary of this function goes here
  %   Detailed explanation goes here

  qAnn = ann * A + repmat(t,[obj.nVert,1]);

end

