classdef RF
  %RF Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    ref_ann
    
    tc
    n_vert
    
    res
    n_pixels
    
    uv
    uv_vec
    mask1
    n_face_pixels1
    
    mask2 
    n_face_pixels2
    
    parts
    n_parts
  end

  methods
    function obj = RF(ref_ann,parts,erode1,erode2)
      obj.ref_ann = ref_ann;
      obj.n_vert = size(ref_ann,1);
      obj.parts = parts;
      obj.n_parts = length(parts);
      
      minimum = min(obj.ref_ann);
      maximum = max(obj.ref_ann);
      obj.tc = obj.ref_ann - repmat(minimum-2,[obj.n_vert,1]);
      
      obj.res = fliplr(ceil(maximum - minimum + 3));
      obj.n_pixels = obj.res(1) * obj.res(2);

      obj.mask1 = obj.ComputeMask(obj.parts{1},erode1); 
      obj.n_face_pixels1 = length(find(obj.mask1==1));
      obj.mask2 = obj.ComputeMask(obj.parts{1},erode2); 
      obj.n_face_pixels2 = length(find(obj.mask2==1));
      
      [obj.uv(:,2),obj.uv(:,1)] = find(obj.mask1 == true);
      obj.uv_vec = obj.uv(:,2) + (obj.uv(:,1) - 1) * obj.res(1);
    end
    
    mask = ComputeMask(obj,contour,erode)
  end
  
end

