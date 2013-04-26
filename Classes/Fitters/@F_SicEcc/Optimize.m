function [delta,c] = Optimize(obj,level,tex,c)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes here

  if isempty(c)
    c = obj.texModel{level}.Tex2Coeff(tex);
    c = c(1:obj.nTexs(level));
  end
        
  [t,tt] = obj.texModel{level}.Coeff2Tex(c);

  [dt_dx,dt_dy] = obj.texModel{level}.Coeff2VTex(c);

  dT_dp = obj.texModel{level}.Compute_dT_dp(obj.tShapes(level),dt_dx,dt_dy,obj.dW_dp{level},t,tt);
  dT_dc = obj.texModel{level}.Compute_dT_dc(obj.nTexs(level),t,tt);

  G = [dT_dp,dT_dc];
  Q = G' * G;

  v = t' * t;
  vBold = G' * t;
  num = v; % - vBold' / Q * vBold;

  u = t' * tex;
  uBold = G' * tex;
  den = u; % - uBold' / Q * vBold;

  if u >  uBold' / Q * vBold
    lambda = num / den;
  else
    if u <=  uBold' / Q * vBold
      lambda1 = sqrt((vBold' / Q * vBold) / (uBold' / Q * uBold));
      lambda2 = (uBold' / Q * vBold - u) / (uBold' / Q * uBold);
      lambda = max(lambda1,lambda2);
    else
      disp('Error in computation of lambda');
    end
  end

  SD_delta = lambda * uBold - vBold;
  delta = Q \ SD_delta;

  c = c + delta(obj.tShapes(level)+1:end);
  
  delta = delta(1:obj.tShapes(level));
    
end

