function [sShape] = Ann2SimShape(~,ann)
  %ANN2SIMSHAPE Summary of this function goes here
  %   Detailed explanation goes here
  
 sShape = squeeze(ann(:,1,:) + 1i*ann(:,2,:));

end

