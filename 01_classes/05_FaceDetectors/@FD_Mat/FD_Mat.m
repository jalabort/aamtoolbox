classdef FD_Mat < FD
  %FD_MAT Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    detector
  end
  
  methods
    function obj = FD_Mat()
      obj.detector = vision.CascadeObjectDetector();
    end
  end
  
end

