function [cann] = dWodW(obj,mu_ann,qpr_ann,ann)
  %DWODW Summary of this function goes here
  %   Detailed explanation goes here

  cann = zeros(size(ann));
  
  for i = 1:obj.rf.n_vert
    
    tx = qpr_ann(i,1);
    ty = qpr_ann(i,2);
    this_tri = obj.sorted_tri{i};
    v = zeros(length(this_tri),2);
    
    for j = 1:length(this_tri)
      
      trij = this_tri(j);
      v0x = mu_ann(obj.tri(trij,1),1);
      v0y = mu_ann(obj.tri(trij,1),2);
      v1x = mu_ann(obj.tri(trij,2),1);
      v1y = mu_ann(obj.tri(trij,2),2);
      v2x = mu_ann(obj.tri(trij,3),1);
      v2y = mu_ann(obj.tri(trij,3),2);
        
      vt0 = ann(obj.tri(trij,1),1:2);
      vt1 = ann(obj.tri(trij,2),1:2);
      vt2 = ann(obj.tri(trij,3),1:2);
      
      a = v2y - v0y;
      b = v2x - v0x;
      c = v1x - v0x;
      d = v1y - v0y;
      
      den = c * a - d * b;
        
      a = ((tx - v0x) * a - (ty - v0y) * b) / den;
      b = ((ty - v0y) * c - (tx - v0x) * d) / den;
        
      v(j,:) = vt0 + a * (vt1 - vt0) + b * (vt2 - vt0);
      
    end
    
    cann(i,:) = mean(v);    
  
  end

end

