function [mu,pc,ev] = Compute(obj,data)
  %Compute Summary of this function goes here
  %   Detailed explanation goes here

  n_data = size(data,2);
  
  mu = mean(data,2);
  cent_data = data - repmat(mu,[1,n_data]);

  if obj.Lp
    [pc,ev] = myLpPCA(cent_data,obj.Lp,0,0,0,0);   
  else
    [pc,ev] = myPCA(cent_data,0,0,0);  
  end
  
end