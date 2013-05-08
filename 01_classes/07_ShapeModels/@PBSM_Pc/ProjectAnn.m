function [qpr_ann,q,p,r] = ProjectAnn(obj,ann)
  %PROJECTANN Summary of this function goes here
  %   Detailed explanation goes here
  
  
  shape = obj.Ann2Shape(ann);
  A = obj.GetDXYDQPR();
  qpr_shape =  A * (pinv(A) * shape);
  qpr_ann = obj.Shape2Ann(qpr_shape);
  q = [];
  p = [];
  r = [];
  
  

%   shape = obj.Ann2Shape(ann);
%   q = obj.Shape2Q(shape);
%   pr_shape = obj.RemoveQ(shape,q);
%     
%   p = obj.Shape2P(pr_shape);
%   p_shape = obj.P2Shape(p);
%   r_shape = obj.RemoveP(pr_shape,p_shape);
%   
%   r = obj.Shape2R(r_shape);
%   r_shape = obj.R2Shape(r);
%   
%   pr_shape = obj.ApplyP(r_shape,p_shape);
%   qpr_shape = obj.ApplyQ(pr_shape,q);
%   
%   qpr_ann = obj.Shape2Ann(qpr_shape);
%   
end



