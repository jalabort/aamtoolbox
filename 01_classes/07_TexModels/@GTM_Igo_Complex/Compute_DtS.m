function [tex] = Compute_DtS(obj,tex)
  %Compute_DtS Summary of this function goes here
  %   Detailed explanation goes here

  tex = 1 / obj.variance * obj.ProjectOut(tex);

end

