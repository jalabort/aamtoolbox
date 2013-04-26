classdef TM_Euler < TM
  %TM_EULER Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    n_ch
    alpha_pi
    g_type
  end
  
  methods
    function obj = TM_Euler(img,n_img,mask,n_face_pixels,res,mask2,n_face_pixels2,smoother,g_type,alpha)
      obj@TM(mask,n_face_pixels,res,mask2,n_face_pixels2,smoother);
      
      obj.pca = PCA_N();
      
      obj.g_type = g_type;
      
      obj.alpha_pi = alpha * pi;
      
      [img,n_img_ch] = obj.ColorTransformAll(img,n_img);
      
      obj.n_ch = 2*n_img_ch;
      
      euler_tex = obj.TransformAll(img,n_img,n_img_ch);
      
      [obj.mu,obj.pc,obj.ev,obj.n_pc] = obj.pca.Compute(euler_tex,n_img);
      
      obj.n_c = obj.n_pc;
    end
    
    igoTex = Transform(obj,aliImg,nCh)
    
    t = GetMean(obj);
    t = ProjectOut(obj,t,nTexs)
  end

end

