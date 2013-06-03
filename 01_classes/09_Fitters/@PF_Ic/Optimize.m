function [delta,c] = Optimize(obj,i,tex,c,~)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes here
  
  tex = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(tex));

  J = 0;
  H = 0;
  
  aux = tex' * obj.tm{i}.pc(:,1:obj.tm{i}.n_c);
  
  for j = 1:obj.tm{i}.n_c
    aux2 = obj.J{i}(:,:,j)' * tex;
    aux3 = (1/obj.tm{i}.ev(j)) * aux2;
    J = J + aux(j) * aux3; 
    H = H + (aux2 * aux3') ; 
    
  end
  
  delta = - (H \ J);

end



