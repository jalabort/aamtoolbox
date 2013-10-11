function [mu,pc,ev] = Compute(obj,data)
  %Compute Summary of this function goes here
  %   Detailed explanation goes here

  if obj.Lp
    [pc,ev] = myLpPCA(data,obj.Lp,0,0,0,0);   
  else
    [pc,ev] = myPCA(data,0,0,0);  
  end
  
  mu = [];
  
end

