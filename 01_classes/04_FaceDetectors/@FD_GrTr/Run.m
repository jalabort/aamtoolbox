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
  
%   q = p(1:sm{1}.n_q);
  ann = sm{1}.P2Ann(p);
%   factor = sm{1}.sim_mu(1) ./  sm{1}.sim_basis(1,1);
%   
  for i = 1:length(sm)
    sm{i}.mu_ann = ann;
    sm{i}.mu = ann(:);
    sm{i}.sim_mu = ann(:);
  end
%   
%   q = obj.noise_scale * factor * randn(sm{1}.n_q,1);
%   ann = sm{1}.P2Ann(q);
  p = zeros(3,2);
  pp = p;
  p(1,:) = ann(1,:);
  p(2,:) = ann(9,:);
  p(3,:) = ann(17,:);
  pp(1,:) = p(1,:) + obj.noise_scale * randn(1,2);
  pp(2,:) = p(2,:) + obj.noise_scale * randn(1,2);
  pp(3,:) = p(3,:) + obj.noise_scale * randn(1,2);
  
  [A,t] = computeaffinebetwennpoints(p,pp);
  
  ann = ann * A + repmat(t,[sm{1}.n_vert,1]);
  p = sm{1}.Ann2ST(ann);
  ann = sm{1}.P2Ann(p);

end

