function [obj] = ToIntensity(obj)
  %ToIntensity Summary of this function goes here
  %   Detailed explanation goes here

  for i = 1:obj.n_data
    if size(obj.data{i}.img,3) == 3
      obj.data{i}.img = rgb2gray(obj.data{i}.img);
    end
  end
  
  obj.n_ch = 1;

end

