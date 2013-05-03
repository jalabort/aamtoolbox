classdef TM_Igo_Complex < TM
  %TM_IGO_COMPLEX Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
  end
  
  methods
    function obj = TM_Igo_Complex(aliImgs,nImgs,mask,res,nFacePixels,nCh,smoother)
      obj@TM(mask,res,nFacePixels,nCh,smoother);
      obj.pca = PCA_N();
      [igoTexs,obj.nCh] = obj.TransformAll(aliImgs,nImgs,nCh);
      igoTexs(isnan(igoTexs)) = 0;
      [obj.MU,obj.PC,obj.EV,obj.nDim] = obj.pca.Compute(igoTexs,nImgs);
    end
    
    igoTex = Transform(obj,aliImg,nCh)
    [transTexs,nCh] = TransformAll(obj,aliImgs,nImgs,nCh)
    
    [t] = GetMean(obj);
    t = ProjectOut(obj,t,nTexs)
    
    [dt_dx,dt_dy] = Compute_dt_dxy(obj,t)
    
    [dT_dx,dT_dy] = Compute_dT_dX(obj,nTexs)
    [dt_dx,dt_dy] = Coeff2VTex(obj,coeff)
  end

end

