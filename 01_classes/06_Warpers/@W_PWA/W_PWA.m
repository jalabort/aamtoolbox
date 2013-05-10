classdef W_PWA < W
  %W_PWA Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    u2u1
    u3u1
    v2v1
    v3v1
    den
    num1
    num2
    u
    v
    ind_base
    alphas
    betas
    gammas
    
    tri_base
    tri
    n_tri
    sorted_tri
    
    c_pixel_tri
    c_alphas
    c_betas
    c_gammas
    c_sorted_tri
    c_tri
    c_i_base
    c_i_vert
    c_i_tri
    c_n_vert
    c_n_tri
    c_n_sorted_tri
    c_n_warped_pixels
    c_n_composed_vert
  end
  
  methods
    function obj = W_PWA(rf,tri,interp)
      obj = obj@W(rf,interp);
      obj.tri = tri;
      obj.n_tri = size(tri,1);
      obj.tri_base = obj.ComputeTriBase();
      obj.sorted_tri = obj.SortTri();
      for i = 1:obj.n_tri
        uu = obj.rf.tc(obj.tri(i,:),1);
        vv = obj.rf.tc(obj.tri(i,:),2);
        obj.u2u1{i} = uu(2) - uu(1);
        obj.u3u1{i} = uu(3) - uu(1);
        obj.v2v1{i} = vv(2) - vv(1);
        obj.v3v1{i} = vv(3) - vv(1);
        obj.den{i} = obj.u2u1{i} * obj.v3v1{i} - obj.v2v1{i} * obj.u3u1{i};
        obj.num1{i} = vv(1) * obj.u3u1{i} - uu(1) * obj.v3v1{i};
        obj.num2{i} = uu(1) * obj.v2v1{i} - vv(1) * obj.u2u1{i};
        [obj.v{i}, obj.u{i}] = find(obj.tri_base == i);
        if ~isempty(obj.v{i}) && ~isempty(obj.u{i})
          obj.ind_base{i} = obj.v{i} + (obj.u{i} - 1) * obj.rf.res(1);
          obj.alphas{i} = ((obj.u{i} - uu(1)) .* obj.v3v1{i} - (obj.v{i} - vv(1)) .* obj.u3u1{i}) / obj.den{i};
          obj.betas{i}  = ((obj.v{i} - vv(1)) .* obj.u2u1{i} - (obj.u{i} - uu(1)) .* obj.v2v1{i}) / obj.den{i};
          obj.gammas{i} = 1 - (obj.alphas{i} + obj.betas{i});
        end
      end
      obj = obj.InitializeC();
    end
    
    tri_base = ComputeTriBase(obj)
    sorted_tri = SortTri(obj)
  end
  
end

