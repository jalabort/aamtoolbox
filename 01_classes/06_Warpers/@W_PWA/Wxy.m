function [wxy,xy] = Wxy(obj,ann,res)
  %Wxy Summary of this function goes here
  %   Detailed explanation goes here
  
  wxy = zeros(size(obj.rf.xy));
  xy = zeros(size(obj.rf.xy,1),1);

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
      
      e = s + length(list)-1;
      
      wxy(s:e,:) = target(list,:);
      xy(s:e,:) = obj.ind_base{i}(list);
      
      s = e + 1;
      
    end
    
  end
  
  wxy = wxy(1:e,:);
  xy = xy(1:e,:);

end

