classdef TM_Euler_Complex < TM
  %TM_EULER_COMPLEX Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    n_ch
    alpha_pi
  end
  
  methods
    function obj = TM_Euler_Complex(img,n_img,mask,res,n_face_pixels,smoother,alpha)
      obj@TM(mask,res,n_face_pixels,smoother);
      
      obj.pca = PCA_N();
      
      obj.alpha_pi = alpha * pi;
      
      [img,n_img_ch] = obj.ColorTransformAll(img,n_img);
      
      obj.n_ch = n_img_ch;
      
      euler_tex = obj.TransformAll(img,n_img,n_img_ch);
      euler_tex(isnan(euler_tex)) = 0;
      
      [obj.mu,obj.pc,obj.ev,obj.n_pc] = obj.pca.Compute(euler_tex,n_img);
      
      obj.n_c = obj.n_pc;
    end
    
    igoTex = Transform(obj,aliImg,nCh)
    
    t = GetMean(obj);
    t = ProjectOut(obj,t,nTexs)
    
    [dt_dx,dt_dy] = ComputeDTDXY(obj,t)
  end

end

