classdef W_TPS < W
  %W_TPS Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    S
    s
    r
    K
    L
    invL
    
    k
  end
  
  methods
    function obj = W_TPS(rf,interp)
      obj = obj@W(rf,interp);
      
      obj.S = [ones(rf.n_vert,1),rf.tc];
      
      obj.s = zeros(obj.rf.n_vert,obj.rf.n_vert,2);
      obj.r = zeros(obj.rf.n_vert,obj.rf.n_vert);
      for j = 1:obj.rf.n_vert
        obj.s(:,j,:) = obj.rf.tc - repmat(obj.rf.tc(j,:),[obj.rf.n_vert,1]);
        obj.r(:,j) = sqrt(sum(squeeze(obj.s(:,j,:)).^2,2));
      end
      mask = obj.r == 0;
      obj.K = obj.r.^2 .* log(obj.r.^2);
      obj.K(mask) = 0; 
      
      obj.L = zeros(rf.n_vert+3);
      obj.L(1:end-3,end-2:end) = obj.S;
      obj.L(end-2:end,1:end-3) = obj.S';
      obj.L(1:end-3,1:end-3) = obj.K;
      obj.invL = inv(obj.L);
      
      r2 = zeros(rf.n_face_pixels1,rf.n_vert); 
      for v = 1:rf.n_vert
        r2(:,v) = sqrt(sum((obj.rf.uv - repmat(obj.rf.tc(v,:),[obj.rf.n_face_pixels1,1])).^2,2));
      end
      obj.k = [r2.^2 .* log(r2.^2),ones(obj.rf.n_face_pixels1,1),obj.rf.uv(:,1),obj.rf.uv(:,2)];
    end
    
    U = GetWeights(obj,ann);
  end

end