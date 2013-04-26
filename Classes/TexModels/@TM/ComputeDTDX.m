function [dt_dx,dt_dy] = ComputeDTDX(obj)
%COMPUTEDTDX Summary of this function goes here
%   Detailed explanation goes here

  dt_dx = zeros(obj.n_ch*obj.n_face_pixels,obj.n_c);
  dt_dy = zeros(obj.n_ch*obj.n_face_pixels,obj.n_c);
 
  for i = 1:obj.n_c
    [dt_dx(:,i),dt_dy(:,i)] = obj.ComputeDTDXY(obj.pc(:,i)); 
  end
  
end

