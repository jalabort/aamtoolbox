function [xy,uv_vec] = Wuv(obj,ann,res)
  %Wuv Summary of this function goes here
  %   Detailed explanation goes here
  
  xy = zeros(size(obj.rf.uv));
  uv_vec = zeros(size(obj.rf.uv_vec));

  s = 1;
  for i = 1:obj.n_tri
    x = ann(obj.tri(i,:),1);
    y = ann(obj.tri(i,:),2);

    if ~isempty(obj.alphas{i}) && ...
        ~isempty(obj.betas{i}) && ...
        ~isempty(obj.gammas{i})
      
      wx = x(1) * obj.gammas{i} + x(2) * obj.alphas{i} + x(3) * ...
        obj.betas{i};
      wy = y(1) * obj.gammas{i} + y(2) * obj.alphas{i} + y(3) * ...
        obj.betas{i};
      
      target = [wx,wy];

      list = target(:,1) > 0 & ...
        target(:,1)<= res(2) & ...
        target(:,2) > 0 & ...
        target(:,2)<= res(1);
      
      if all(list)
        list_length = length(list);
      else
        list_length = length(find(list==1));
      end
      
      e = s + list_length - 1;
      
      xy(s:e,:) = target(list,:);
      uv_vec(s:e) = obj.uv_vec_triangle{i}(list);
      
      s = e + 1;
      
    end
    
  end
  
  xy = xy(1:e,:);
  uv_vec = uv_vec(1:e);

end

