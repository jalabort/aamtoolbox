classdef TM_Igo < TM
  %TM_IGO Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    A
    n_ch
    g_type
  end
  
  methods
    function obj = TM_Igo(img,n_img,mask,n_face_pixels,res,mask2,n_face_pixels2,smoother,g_type)
      obj@TM(mask,n_face_pixels,res,mask2,n_face_pixels2,smoother);
      
      obj.pca = PCA_Noncent();
      
      obj.g_type = g_type;
      
      [img,n_img_ch] = obj.ColorTransformAll(img,n_img);
      
      obj.n_ch = 2*n_img_ch;
      
      igo_tex = obj.TransformAll(img,n_img,n_img_ch);
      
      [obj.mu,obj.pc,obj.ev,obj.n_pc] = obj.pca.Compute(igo_tex,n_img);
      
      obj.A = obj.Img2Tex(obj.Tex2Img2(obj.pc(:,2:end)));
      [obj.A, ~] = qr(obj.A,0);
      
      obj.n_c = obj.n_pc;
    end
    
    igo_tex = Transform(obj,img,n_img_ch)
    
    t = GetMean(obj);
    t = ProjectOut(obj,t)
  end

end

