function [regExpQuery] = RegExpQuery(obj,id,exp,pose,light)
  %REGEXPQUERY Summary of this function goes here
  %   Detailed explanation goes here
  
  ids = '(';
  for i = id
    ids = [ids obj.list.id{i} '|'];
  end
  ids(end) = ')';
  
  exps = '(';
  for i = exp
    exps = [exps obj.list.exp{i} '|'];
  end
  exps(end) = ')';
  
  poses = '(';
  for i = pose
    poses = [poses obj.list.pose{i} '|'];
  end
  poses(end) = ')';
  
  regExpQuery = ['x' ids '_' exps '_' poses '_' light];

end

