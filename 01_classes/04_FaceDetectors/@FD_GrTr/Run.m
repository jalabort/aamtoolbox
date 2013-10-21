function [ann,detected,sm,p] = Run(obj,sm,~,grtr_ann)
  %Run Summary of this function goes here
  %   Detailed explanation goes here
  
  detected = true;
  
  if obj.rotation
    % if rotation flag is on
    p = sm{1}.Ann2SRT(grtr_ann);
  else
    % if not
    p = sm{1}.Ann2ST(grtr_ann);
  end
  
  [A,t] = sm{1}.Q2MatForm(p(1:sm{1}.n_q));
  ann = sm{1}.mu_ann * A + repmat(t,[sm{1}.n_vert,1]);
  range = max(ann) - min(ann);
  
  noisy_A = A + obj.noise_scale * randn(size(A)) .* A;
  noisy_t = t + obj.noise_scale * randn(size(t)) .* range;
  
  ann = sm{1}.mu_ann * noisy_A + repmat(noisy_t,[sm{1}.n_vert,1]);
  
  for i = 1:length(sm)
    sm{i}.mu_ann = ann;
    sm{i}.mu = ann(:);
    sm{i}.sim_mu = ann(:);
  end
  
  p = sm{1}.Ann2SRT(ann);

  ann = sm{1}.P2Ann(p);
  
end

