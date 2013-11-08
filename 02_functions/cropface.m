function [img,ann] = cropface(img,ann)
  %cropface Summary of this function goes here
  %   Detailed explanation goes here
    
  max_ = ceil(max(ann) + 10);
  max_(1) = min(max_(1),size(img,2));
  max_(2) = min(max_(2),size(img,1));
  
  min_ = floor(min(ann) - 10);
  min_(1) = max(min_(1),1);
  min_(2) = max(min_(2),1);
  
  img = img(min_(2):max_(2),min_(1):max_(1),:);
  ann = ann - repmat(min_,[size(ann,1),1]);
  
end

