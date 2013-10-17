function [obj] = NormalizeFaceSize(obj,sm)
  %NormalizeFaceSize Summary of this function goes here
  %   Detailed explanation goes here

  for i = 1:obj.n_data
    [obj.data{i}.img,obj.data{i}.ann] = normalizefacesize(obj.data{i}.img,obj.data{i}.ann,sm);
  end

end

