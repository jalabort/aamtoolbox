function [obj] = PreComputeDense(obj,i)
  %PreComputeDense Summary of this function goes here
  %   Detailed explanation goes here
  
  obj.t{i} = obj.tm{i}.GetMean();
  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(obj.t{i});

  dWdp = obj.sm{i}.Compute_duvidp();
  
  J = obj.tm{i}.Compute_dtdp(dtdx,dtdy,dWdp);
  J2 = obj.tm{i}.ProjectOut(J);
  obj.J{i} = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J),1);
  J2 = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J2),1);
  
  obj.invH{i} = inv(J2' * obj.J{i});
  
end

