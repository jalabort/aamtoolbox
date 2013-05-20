function [srt] = Ann2ST(obj,ann)
  %Ann2ST Summary of this function goes here
  %   Detailed explanation goes here

  srt = obj.Ann2P(ann);
   
  % I need to work out how to kill the rotation from the complex 
  % parameters about this!!!
  %srt([2,5:end]) = 0;

end

