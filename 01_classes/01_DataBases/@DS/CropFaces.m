function [obj] = CropFaces(obj)
  %CropFaces Summary of this function goes here
  %   Detailed explanation goes here

  for i = 1:obj.n_data
    [obj.data{i}.img,obj.data{i}.ann] = cropface(obj.data{i}.img,obj.data{i}.ann);
  end

end

