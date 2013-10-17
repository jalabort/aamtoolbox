function [img,ann] = scaleimg(img,ann,scale,smoother)
  %normalizefacesize Summary of this function goes here
  %   Detailed explanation goes here
  
  if ~isempty(smoother)
    img = smoother.Run(img);
  end
  img = imresize(img,scale);
  ann = ann .* scale;

end

