function [delta,c] = Optimize(obj,i,tex,c,~)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes here
  
  tex = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(tex));

  u = obj.t{i}' * tex;
  ubold = obj.J{i}' * tex;
  aux2 = ubold' * obj.invH_x_vbold{i};
  den = u - aux2;

  if u >  aux2
    lambda = obj.num{i} / den;
  else
    if u <=  aux2
      aux3 = (ubold'  * invH * ubold);
      lambda1 = sqrt(obj.aux1{i} / aux3);
      lambda2 = (aux2 - u) / aux3;
      lambda = max(lambda1,lambda2);
    else
      disp('Error in computation of lambda');
    end
  end

  J_x_error = lambda * obj.vbold{i} - ubold;
  delta = obj.invH{i} * J_x_error;
  delta = 0.1 * delta;

end

