function [obj] = AddLevel(obj,sm,w,tm,smoother)
  %ADDLEVEL Summary of this function goes here
  %   Detailed explanation goes here

  obj.n_level = obj.n_level + 1;
  obj.sm{n_level} = sm;
  obj.w{n_level} = w;
  obj.tm{n_level} = tm;
  obj.smoother{n_level} = smoother;
  
end

