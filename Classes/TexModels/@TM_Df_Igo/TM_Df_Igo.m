classdef TM_Df_Igo < TM
  %TM_DF_IGO Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    n_ch
    
    bin
    n_bin
  end
  
  methods
    function obj = TM_Df_Igo(img,n_img,mask,res,n_face_pixels,smoother)
      obj@TM(mask,res,n_face_pixels,smoother);
      
      obj.pca = PCA_N();
      
      [img,n_img_ch] = obj.ColorTransformAll(img,n_img);
      
      [igo_tex,obj.n_ch] = obj.TrainTransformAll(img,n_img,n_img_ch);
      igo_tex(isnan(igo_tex)) = 0;
      
      [obj.mu,obj.pc,obj.ev,obj.n_pc] = obj.pca.Compute(igo_tex,n_img);
    end
    
    [bin] = SetBin(obj)
    [df_tex,aux] = C2Tex(obj,c)
    
    img = Tex2Img(obj,tex)
    tex = Img2Tex(obj,img)
    
    igo_tex = TrainTransform(obj,img,n_img_ch)
    [igo_tex,n_ch] = TrainTransformAll(obj,img,n_img,n_img_ch)
    
    [df_tex] = FitTransform(obj,img,n_img_ch)
    
    [t] = GetMean(obj);
    t = ProjectOut(obj,t,n_c)
    
    [dt_dx,dt_dy] = ComputeDTDXY(obj,t)
    dt_dp = ComputeDTDQPR(obj,n_qpr,tx,ty,dW_dp,t,tt)

  end

end

