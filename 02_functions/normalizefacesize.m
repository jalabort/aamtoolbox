function [img,ann,scale] = normalizefacesize(img,ann,sm)
  %normalizefacesize Summary of this function goes here
  %   Detailed explanation goes here
    
  p = sm.Ann2ST(ann);
  [A,~] = sm.Q2MatForm(p(1:sm.n_q));
  scale = 1 / A(1);
    
  img = imresize(img,scale);
  ann = ann .* scale;

end

