function [obj] = ToIgoDouble(obj)
  %ToIgoDouble Summary of this function goes here
  %   Detailed explanation goes here

  for i = 1:obj.n_data
    [obj.data{i}.img] = img2igodouble(obj.data{i}.img);
  end

  obj.n_ch = 4;
  
end

