function [ann] = getAnn(obj)
  %GETANN Summary of this function goes here
  %   Detailed explanation goes here
  
  ann = zeros(obj.n_vert,2,obj.n_data);
  for i = 1:obj.n_data
    ann(:,:,i) = obj.data{i}.ann;
  end

end

