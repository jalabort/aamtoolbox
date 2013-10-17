function [obj] = Scale(obj,scale,smoother)
  %NormalizeFaceSize Summary of this function goes here
  %   Detailed explanation goes here

  for i = 1:obj.n_data
    [obj.data{i}.img,obj.data{i}.ann] = scaleimg(obj.data{i}.img,obj.data{i}.ann,scale,smoother);
  end

end
