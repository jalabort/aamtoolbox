classdef (Abstract) TM
  %TM Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    pca
    
    mu
    pc
    ev
    n_pc
    
    dt_dx
    dt_dy
    
    n_c

    mask
    n_face_pixels 
    
    res
    mask2
    n_face_pixels2 
    
    smoother
  end
  
  methods
    function obj = TM(mask,n_face_pixels,res,mask2,n_face_pixels2,smoother)
      obj.mask = mask;
      obj.n_face_pixels = n_face_pixels;
      obj.res = res;
      obj.mask2 = mask2;
      obj.n_face_pixels2 = n_face_pixels2;
      obj.smoother = smoother;
    end
    
    c = Tex2C(obj,tex,n_c)
    [tex,aux] = C2Tex(obj,c)
    
    img = Tex2Img(obj,tex)
    tex = Img2Tex(obj,img)
    
    ch = getTexCh(obj,tex,ch)
    
    [cimg] = obj.ColorTransform(img);
    [cimg,n_img_ch] = obj.ColorTransformAll(img,n_img);
    
    trans_tex = obj.TransformAll(img,n_img);
    
    [dt_dx,dt_dy] = C2VT(obj,c)
    
    [dt_dx,dt_dy] = ComputeDTDXY(obj,t)
    [dt_dx,dt_dy] = ComputeDTDX(obj)
    dt_dc = ComputeDTDC(obj,n_c,t,tt)
    dt_dp = ComputeDTDQPR(obj,n_qpr,tx,ty,dW_dp,t,tt)
  end
  
end

