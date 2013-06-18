function [tex] = TransformCh(obj,img)
  %TrandformCh Summary of this function goes here
  %   Detailed explanation goes here
  
  
  img = vl_hog(single(img),obj.cell_size,'NumOrientations',obj.n_ch_features);
  tex = obj.Img2Tex(img);
  
end

