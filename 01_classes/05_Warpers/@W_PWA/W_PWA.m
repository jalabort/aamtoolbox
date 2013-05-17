classdef W_PWA < W
  %W_PWA Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    uv_vec_triangle
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
      
      u2u1 = cell(obj.n_tri,1);
      u3u1 = cell(obj.n_tri,1);
      v2v1 = cell(obj.n_tri,1);
      v3v1 = cell(obj.n_tri,1);
      den = cell(obj.n_tri,1);
      num1 = cell(obj.n_tri,1);
      num2 = cell(obj.n_tri,1);
      v = cell(obj.n_tri,1);
      u = cell(obj.n_tri,1);
      for i = 1:obj.n_tri
        uu = obj.rf.tc(obj.tri(i,:),1);
        vv = obj.rf.tc(obj.tri(i,:),2);
        u2u1{i} = uu(2) - uu(1);
        u3u1{i} = uu(3) - uu(1);
        v2v1{i} = vv(2) - vv(1);
        v3v1{i} = vv(3) - vv(1);
        den{i} = u2u1{i} * v3v1{i} - v2v1{i} * u3u1{i};
        num1{i} = vv(1) * u3u1{i} - uu(1) * v3v1{i};
        num2{i} = uu(1) * v2v1{i} - vv(1) * u2u1{i};
        [v{i},u{i}] = find(obj.tri_base == i);
        if ~isempty(v{i}) && ~isempty(u{i})
          obj.uv_vec_triangle{i} = v{i} + (u{i} - 1) * obj.rf.res(1);
          obj.alphas{i} = ((u{i} - uu(1)) .* v3v1{i} - (v{i} - vv(1)) .* u3u1{i}) / den{i};
          obj.betas{i}  = ((v{i} - vv(1)) .* u2u1{i} - (u{i} - uu(1)) .* v2v1{i}) / den{i};
          obj.gammas{i} = 1 - (obj.alphas{i} + obj.betas{i});
        end
      end
      
      %obj = obj.InitializeC();
    end
    
    tri_base = ComputeTriBase(obj)
    sorted_tri = SortTri(obj)
    
    [xy,uv] = Wuv(obj,ann,res);
  end
  
end

