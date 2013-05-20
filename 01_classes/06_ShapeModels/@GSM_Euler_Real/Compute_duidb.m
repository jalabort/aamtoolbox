function [duidb] = Compute_duidb(obj)
  %Compute_duidb Summary of this function goes here
  %   Detailed explanation goes here

  aux = repmat(obj.pc(:,1),1,obj.n_b) .* obj.pc;
  aux2 = aux(1:2*obj.n_vert,:) - aux(2*obj.n_vert+1:end,:);
  duidb = aux2 ./ ...
    repmat(sqrt(obj.pc(1:2*obj.n_vert,1).^2 + obj.pc(2*obj.n_vert+1:end,1).^2),1,obj.n_b);

end

