classdef FD_GrTr < FD
  %FD_GrTr Summary of this class goes here
  %   Detailed explanation goes here

  methods
    function obj = FD_GrTr(rotation)
      if nargin > 0
        obj.rotation = rotation;
      end
    end
  end
  
end

