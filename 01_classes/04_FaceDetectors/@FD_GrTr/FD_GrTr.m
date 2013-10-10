classdef FD_GrTr < FD
  %FD_GrTr Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    noise_scale = 0
  end

  methods
    function obj = FD_GrTr(rotation, noise_scale)
      if nargin > 0
        obj.noise_scale = noise_scale;
        obj.rotation = rotation;
      end
      
    end
  end
  
end

