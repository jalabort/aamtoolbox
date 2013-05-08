function [ann] = SimShape2Ann(obj,sShapes)
  %SIMSHAPE2ANN Summary of this function goes here
  %   Detailed explanation goes here

  ann = reshape(sShapes,obj.nVert,2,[]);
  
end