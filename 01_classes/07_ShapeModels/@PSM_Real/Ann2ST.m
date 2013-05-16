function [srt] = Ann2ST(obj,ann)
  %Ann2ST Summary of this function goes here
  %   Detailed explanation goes here

  srt = obj.Ann2P(ann);
  srt([2,5:end]) = 0;

end

