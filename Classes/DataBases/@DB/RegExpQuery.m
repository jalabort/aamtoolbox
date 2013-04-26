function [reg_exp_query] = RegExpQuery(obj,id)
  %REGEXPQUERY Summary of this function goes here
  %   Detailed explanation goes here
  
  ids = '(';
  for i = id
    ids = [ids obj.list.id{i} '|'];
  end
  ids(end) = ')';
  
  reg_exp_query = ['x' ids];

end

