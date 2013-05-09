classdef DS
  %DS Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    name
    regExpQuery
    
    data
    n_data
    
    n_vert
    n_ch
    
    tri
    n_tri
    
    comp
    n_comp
    
    parts
    n_parts
  end
  
  methods
    function obj = DS(dB,data,regExpQuery)
      obj.name = dB.name;
      obj.regExpQuery = regExpQuery;
      obj.data = data;
      obj.n_data = length(data);
      obj.n_vert = dB.n_vert;
      obj.n_ch = dB.n_ch;
      obj.tri = dB.tri;
      obj.n_tri = dB.n_tri;
      obj.comp = dB.comp;
      obj.n_comp = dB.n_comp;
      obj.parts = dB.parts;
      obj.n_parts = dB.n_parts;
    end
    
    ann = GetAnn(obj)
    ref_ann = ComputeRefAnn(obj)
  end
  
end

