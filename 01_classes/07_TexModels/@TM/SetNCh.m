function [n_ch,n_face_features] = SetNCh(obj)
  %SetNCh Summary of this function goes here
  %   Detailed explanation goes here
  
  n_ch = obj.n_ch_features * obj.n_ch_img;
  n_face_features =obj.n_ch_features * obj.n_face_pixels1;

end

