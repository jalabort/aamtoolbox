function [ann,q,detected] = Run(sm,~,ori_ann,default_ann,~,~)
  %RUN Summary of this function goes here
  %   Detailed explanation goes here
  
  detected = true;
  
%   ref_shape = sm.Ann2Shape(ori_ann);
%   q = sm.Shape2Q(ref_shape);
%   [A,t] = sm.Q2MatForm(q);
%   A(1,2) = 0;
%   A(2,1) = 0;
%   ann = sm.ApplyQ(default_ann,A,t);
  
  ref_shape = sm.Ann2Shape(ori_ann);
  q = sm.Shape2Q(ref_shape);
  q = [q(1);0;q(3);q(4);0;0];
  ann = sm.Shape2Ann(sm.Q2Shape([q(1);0;q(3);q(4)]));
  

end

