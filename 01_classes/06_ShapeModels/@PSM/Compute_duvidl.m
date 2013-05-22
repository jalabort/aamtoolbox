function [duvidl] = Compute_duvidl(obj)
  %Compute_duvidl Summary of this function goes here
  %   Detailed explanation goes here

  duvidl = obj.pose_pc(:,1:obj.n_l);

end

