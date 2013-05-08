classdef FD_Mat < FD
  %FD_MAT Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    face_det
  end
  
  methods
    function obj = FD_Mat()
      obj.face_det = vision.CascadeObjectDetector();
    end
    
    [ann,q,detected] = Run(obj,sm,img,ori_ann,default_ann,n_vert,res)
  end
  
end

