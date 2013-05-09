classdef DB
  %DB Summary of this class goes here
  %   Detailed explanation goes here
  
  properties  
    name
    scale
    bin_path
    img_path
    ann_path
    
    img_type
    ann_type
    
    n_vert
    n_ch
    
    tri
    n_tri
    
    comp
    n_comp
    
    parts
    n_parts
    
    list
  end
  
  methods 
    function obj = DB(name,bin_root)
      dB_bin_path = [bin_root name '.mat'];
      if exist(dB_bin_path,'file')
        load(dB_bin_path,'obj');
      else
        obj.name = name;
        obj.bin_path = dB_bin_path;
        display([obj.name ' binary DB needs to be build']);
      end
    end
    
    Build(obj,scale,img_path,ann_path,img_type,ann_type,res,n_vert,n_ch)

    reg_exp_query = RegExpQuery(obj,id)
    [data,loaded] = Load(obj,reg_exp_query)
  end
  
end

