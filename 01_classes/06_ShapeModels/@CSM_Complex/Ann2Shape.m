function [shape] = Ann2Shape(~,ann)
  %Ann2Shape Summary of this function goes here
  %   Detailed explanation goes here
  
  shape = squeeze(ann(:,1,:) + 1i*ann(:,2,:));

end

