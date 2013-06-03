function [ds,loaded] = Load(obj,reg_exp_query)
  %Load Summary of this function goes here
  %   Detailed explanation goes here

  load(obj.bin_path,'obj');
  data = struct2cell(load(obj.bin_path, '-regexp', reg_exp_query));
  
  if ~isempty(data)
    ds = DS(obj,data,reg_exp_query);
    loaded = true;
  else
    ds = [];
    loaded = false;
  end
  
end

