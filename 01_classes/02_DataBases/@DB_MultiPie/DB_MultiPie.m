classdef DB_MultiPie < DB
  %DB_MULTIPIE Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    imgRes
  end
  
  methods
    function obj = DB_MultiPie(name,binRoot)
      obj = obj@DB(name,binRoot);
    end
    
    [regExpQuery] = RegExpQuery(obj,id,exp,pose,light)
  end
  
end

