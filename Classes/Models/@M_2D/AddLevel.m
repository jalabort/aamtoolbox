function [n_level,w,sm,tm] = AddLevel(obj,nw,nsm,ntm)
  %ADDLEVEL Summary of this function goes here
  %   Detailed explanation goes here

  n_level = obj.n_ + 1;
  
  w = obj.w;
  w{n_level} = nw;
  
  sm = obj.sm;
  sm{n_level} = nsm;
  
  tm = obj.tm;
  tm{n_level} = ntm;
  
end

