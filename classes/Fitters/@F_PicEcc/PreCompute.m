function [obj] = PreCompute(obj,i)
  %PRECOMPUTE Summary of this function goes here
  %   Detailed explanation goes here

  aux = obj.tm{i}.GetMean();
  obj.t{i} = obj.tm{i}.ProjectOut(aux);
  [dt_dx,dt_dy] = obj.tm{i}.ComputeDTDXY(obj.t{i}); 
  obj.t{i} = obj.tm{i}.Img2Tex(obj.tm{i}.Tex2Img2(obj.t{i}));

  dw_dxy = obj.w{i}.ComputeDWDXY();
  dw_dp = obj.sm{i}.ComputeDWDQPR(dw_dxy);

  aux = obj.tm{i}.ComputeDTDQPR(obj.sm{i}.n_qpr,dt_dx,dt_dy,dw_dp,obj.t{i},[]);
  aux = obj.tm{i}.Img2Tex2(obj.tm{i}.Tex2Img(aux));
  aux = obj.tm{i}.ProjectOut(aux);
  obj.g{i} = obj.tm{i}.Img2Tex(obj.tm{i}.Tex2Img2(aux));
  obj.inv_q{i} = inv(obj.g{i}' * obj.g{i});
  
  obj.v{i} = obj.t{i}' * obj.t{i};
  obj.v_bold{i} = obj.g{i}' * obj.t{i};
  obj.inv_q_v_bold{i} = obj.inv_q{i} * obj.v_bold{i};
  obj.num{i} = obj.v{i} - obj.v_bold{i}' * obj.inv_q_v_bold{i};
  
end
