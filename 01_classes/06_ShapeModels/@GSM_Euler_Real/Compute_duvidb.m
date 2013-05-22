function [duvidb] = Compute_duvidb(obj)
  %Compute_duidb Summary of this function goes here
  %   Detailed explanation goes here

  aux = repmat(obj.mu([2*obj.n_vert+1:end,1:end/2],1),1,obj.n_b) .* ...
    obj.pc(:,1:obj.n_b);
  aux2 = + aux(1:2*obj.n_vert,:) - aux(2*obj.n_vert+1:end,:);
  duvidb = aux2 ./ ...
    (repmat(obj.mu(1:2*obj.n_vert).^2 + ...
    obj.mu(2*obj.n_vert+1:end).^2,1,obj.n_b) * ...
    obj.alpha_pi);

end

