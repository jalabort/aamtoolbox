function [dWdxi] = Compute_dWdxi(obj)
  %COMPUTE_DWDXI Summary of this function goes here
  %   Detailed explanation goes here

  dWdxi = zeros(obj.rf.n_face_pixels,obj.rf.n_vert);
  
  for i = 1:obj.rf.n_vert
    
    tri_set = obj.sorted_tri{i};
    
    for j = 1:length(tri_set)

      t = tri_set(j);
      aux = obj.tri(t,:);
      v = [aux(aux == i),aux(aux ~= i)];

      [y,x] = find(obj.tri_base == t);
      v0x = obj.rf.tc(v(1),1);
      v0y = obj.rf.tc(v(1),2);
      v1x = obj.rf.tc(v(2),1);
      v1y = obj.rf.tc(v(2),2);
      v2x = obj.rf.tc(v(3),1);
      v2y = obj.rf.tc(v(3),2);
      
      v1v0x = v1x - v0x;
      v1v0y = v1y - v0y;
      v2v0x = v2x - v0x;
      v2v0y = v2y - v0y;

      den = v1v0x * v2v0y - v1v0y * v2v0x;
      alpha = (x - v0x) * v2v0y - (y - v0y) * v2v0x;
      beta = (y - v0y) * v1v0x - (x - v0x) * v1v0y;
      
      dxy = zeros(obj.rf.res);
      dxy(sub2ind(obj.rf.res,y,x)) = (1 - alpha / den - beta / den);
      aux = dxy(obj.rf.mask);
      dWdxi(:,i) = dWdxi(:,i) + aux;
    
    end
    
  end

end

