function [tex] = ProjectOut(obj,tex)
  %ProjectOut Summary of this function goes here
  %   Detailed explanation goes here

  tex = tex - ...
    obj.cropped_pc(:,2:obj.n_c) * (obj.cropped_pc(:,2:obj.n_c)' * tex);

end

