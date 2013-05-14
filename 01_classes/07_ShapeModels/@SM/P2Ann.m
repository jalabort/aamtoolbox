function [ann] = P2Ann(obj,p)
  %P2Ann Summary of this function goes here
  %   Detailed explanation goes here

  ann = obj.Shape2Ann(obj.Shape2P(p));

end

