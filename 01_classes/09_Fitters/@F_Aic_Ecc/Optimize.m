function [delta,c] = Optimize(obj,i,tex,~)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes her
  
  c = obj.tm{i}.Tex2C(tex);
  t = obj.tm{i}.C2Tex(c);
  
  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(t);

  J = obj.tm{i}.Compute_dtdp(dtdx,dtdy,obj.dWdp{i});
  J = obj.tm{i}.ProjectOut(J);
  
  invH = inv(J' * J);
   
  t = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(t));
  tex = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(tex));

  v = t' * t;
  vbold = J' * t;
  aux1 = vbold' * invH * vbold;
  num = v - aux1;

  u = t' * tex;
  ubold = J' * tex;
  aux2 = ubold' * invH * vbold;
  den = u - aux2;

  if u >  aux2
    lambda = num / den;
  else
    if u <=  aux2
      aux3 = (ubold'  * invH * ubold);
      lambda1 = sqrt(aux1 / aux3);
      lambda2 = (aux2 - u) / aux3;
      lambda = max(lambda1,lambda2);
    else
      disp('Error in computation of lambda');
    end
  end

  J_x_error = lambda * vbold - ubold;
  delta = invH * J_x_error;

end

