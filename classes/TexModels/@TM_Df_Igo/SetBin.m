function [bin] = SetBin(obj)
  %SETBIN Summary of this function goes here
  %   Detailed explanation goes here

  step = 360 / obj.n_bin;
  bin = -180:step:180;

end

