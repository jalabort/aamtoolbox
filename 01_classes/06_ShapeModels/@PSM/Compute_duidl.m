function [duidl] = Compute_duidl(obj)
  %Compute_duidl Summary of this function goes here
  %   Detailed explanation goes here

  duidl = obj.pose_pc(:,1:obj.n_l);

end

