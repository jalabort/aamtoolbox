classdef RF
  %RF Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    ref_ann
    
    tc
    n_vert
    res
    n_pixels
    
    mask
    mask2
    
    n_face_pixels 
    n_face_pixels2
    
    parts
    n_parts
  end

  methods
    function obj = RF(ref_ann,n_vert,parts,n_parts,erode)
      obj.ref_ann = ref_ann;
      obj.n_vert = n_vert;
      obj.parts = parts;
      obj.n_parts = n_parts;
      minimum = min(obj.ref_ann);
      maximum = max(obj.ref_ann);
      obj.tc = obj.ref_ann - repmat(minimum-2,[obj.n_vert,1]);
      obj.res = fliplr(ceil(maximum - minimum + 3));
      obj.n_pixels = obj.res(1) * obj.res(2);
      obj.mask = obj.ComputeMask(obj.parts{1},erode); 
      obj.n_face_pixels = length(find(obj.mask==1));
      obj.mask2 = obj.ComputeMask(obj.parts{1},1); 
      obj.n_face_pixels2 = length(find(obj.mask2==1));
    end
    
    mask = ComputeMask(obj,contour,erode)
  end
  
end

