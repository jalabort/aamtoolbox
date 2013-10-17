function [obj] = ToIgo(obj)
  %ToIgo Summary of this function goes here
  %   Detailed explanation goes here

  for i = 1:obj.n_data
    [obj.data{i}.img] = img2igo(obj.data{i}.img);
  end
  
  obj.n_ch = 2;

end

