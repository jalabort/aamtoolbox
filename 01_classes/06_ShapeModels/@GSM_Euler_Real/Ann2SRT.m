function [srt] = Ann2SRT(obj,ann)
  %Ann2SRT Summary of this function goes here
  %   Detailed explanation goes here

  srt = obj.Ann2P(ann);
  srt(5:end) = 0;

end

