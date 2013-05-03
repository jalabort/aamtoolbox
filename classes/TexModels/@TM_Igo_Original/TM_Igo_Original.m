classdef TM_Igo_Original < TM_Igo
  %TM_IGO_ORIGINAL Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
  end
  
  methods
    function obj = TM_Igo_Original(aliImgs,nImgs,mask,res,nFacePixels,nCh)
      obj@TM_Igo(aliImgs,nImgs,mask,res,nFacePixels,nCh);
    end
    
    Gdir = GetAngle(obj,igoTex);
    [augIgoTex,igoTex] = Coeff2Tex(obj,coeff)
    
    t = GetMean(obj);
    t = ProjectOut(obj,t,nTexs)

    
    [dT_dx,dT_dy] = Compute_dT_dX(obj,nTexs)
    [dt_dx,dt_dy] = Coeff2VTex(obj,coeff)

    dT_dc = Compute_dT_dc(obj,nTexs,t,tt)
    dT_dp = Compute_dT_dp(obj,nShapes,tx,ty,dW_dp,t,tt)
  end

end

