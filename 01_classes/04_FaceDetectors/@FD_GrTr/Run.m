function [ann,detected,p] = Run(obj,sm,~,grtr_ann)
  %Run Summary of this function goes here
  %   Detailed explanation goes here
  
  detected = true;
  
  if obj.rotation
    % if rotation flag is on
    p = sm.Ann2SRT(grtr_ann);
  else
    % if not
    p = sm.Ann2ST(grtr_ann);
  end
  
  [A,t] = sm.Q2MatForm(p(1:sm.n_q));
  ann = sm.mu_ann * A + repmat(t,[sm.n_vert,1]);
  range = max(ann) - min(ann);
  
  noisy_A = A + obj.noise_scale * randn(size(A)) .* A;
  noisy_t = t + obj.noise_scale * randn(size(t)) .* range;
  
  ann = sm.mu_ann * noisy_A + repmat(noisy_t,[sm.n_vert,1]);
  p = sm.Ann2SRT(ann);

%   ann = sm.P2Ann(p);
  
end

