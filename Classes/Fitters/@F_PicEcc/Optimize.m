function [delta,c] = Optimize(obj,i,tex,c)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes here
  
  tex = obj.tm{i}.ProjectOut(tex);
  
  tex = obj.tm{i}.Img2Tex(obj.tm{i}.Tex2Img2(tex));
  
  u_bold = obj.g{i}' * tex;
  u = obj.t{i}' * tex;
  aux = u_bold' * obj.inv_q_v_bold{i};
  den = u - aux;

  if u >  aux
    lambda = obj.num{i} / den;
  else
    if u <=  aux
      aux2 =  u_bold' * obj.inv_q{i} * u_bold;
      lambda1 = sqrt((obj.v_bold{i}' * obj.inv_q_v_bold{i}) / (aux2));
      lambda2 = (aux - u) / (aux2);
      lambda = max(lambda1,lambda2);
    else
      disp('Error in computation of lambda');
    end
  end

  sd_delta = lambda * u_bold - obj.v_bold{i};
  delta = 0.2 * obj.inv_q{i} * sd_delta;


end

