function [srt] = Ann2SRT(obj,ann)
  %Ann2SRT Summary of this function goes here
  %   Detailed explanation goes here

  srt = obj.Ann2P(ann);
  srt(3:end) = 0;

end

