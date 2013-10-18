classdef (Abstract) TM
  %TM Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    res
    n_pixels
    
    mask1
    n_face_pixels1
    n_face_features1
    
    mask2 
    n_face_pixels2
    n_face_features2
    
    n_c
    n_ch

    feature_type
    factor
    
    sigma_ck
    sigma_ckk
    sigma_c0
  end
  
  methods
    function obj = TM(rf)
      obj.res = rf.res;
      obj.n_pixels = rf.n_pixels;
      obj.mask1 = rf.mask1;
      obj.n_face_pixels1 = rf.n_face_pixels1;
      obj.mask2 = rf.mask2;
      obj.n_face_pixels2 = rf.n_face_pixels2;
    end
    
    img = Tex2Img(obj,tex,n_ch)
    tex = Img2Tex(obj,img,n_ch)
    
    img = CroppedTex2Img(obj,ctex,n_ch)
    ctex = Img2CroppedTex(obj,img,n_ch)
    
    tex_ch = getTexCh(obj,tex,i)
    ctex_ch = getCroppedTexCh(obj,ctex,i)
    
    img = C2Img(obj,c)
    c = Img2C(obj,img)
    img = ProjectImg(obj,img)
    
    dtdp = Compute_dtdp(obj,dtdx,dtdy,dWdp)
    
    Save(obj,opt,i)
  end
  
  methods (Static)
    [obj,loaded] = Load(opt,i)
  end
  
  methods (Abstract)
    c = Tex2C(obj,tex)
    tex = C2Tex(obj,c)
    
    tex = TransformAll(obj,img);
    tex = Transform(obj,img);
    
    [dtdx,dtdy] = Compute_dtdxy(obj,t)
    dAdc = Compute_dAdc(obj)
  end
  
end

