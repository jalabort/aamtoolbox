classdef FD_Mat < FD
  %FD_Mat Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    detector
  end
  
  methods
    function obj = FD_Mat(rotation)
      if nargin > 0
        obj.rotation = rotation;
      end
      obj.detector = vision.CascadeObjectDetector();
    end
  end
  
end

