classdef (Abstract) GTM < TM
  %GTM Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    mu
    pc
    ev
    
    cropped_pc
    
    n_pc
    
    variance
  end
  
  methods
    function obj = GTM(img,rf,smoother)
      obj@TM(rf,smoother);
      
      % number of channels of the original images
      obj.n_ch_img = size(img,3);
      
      % convert images to textures (features)
      [obj.n_ch,obj.n_face_features1,obj.n_face_features2] = obj.SetNCh();
      tex = obj.TransformAll(img);
      
      % compute pca
      [obj.mu,obj.pc,obj.ev] = obj.pca.Compute(tex);
      obj.n_pc = size(obj.pc,2);
      
      % obtain and orthonormalize the cropped pc (necessary to correctly
      % handle possible innacuracies when computing gradients on the 
      % reference frame)
%       obj.cropped_pc = obj.Img2CroppedTex(obj.Tex2Img(obj.pc));
%       [obj.cropped_pc, ~] = qr(obj.cropped_pc,0);
      
      % initialize dinamic size properties
      obj.n_c = obj.n_pc;
      
      % compute the discarted variance
      obj.variance = 0;
    end
    
    variance = ComputeLeftOutVariance(obj)
    [n_c,variance] = SetNC(obj,n_c)
  end
  
  methods (Abstract) 
    tex = TransformCh(obj,img)
    
    t = GetMean(obj)
    t = ProjectOut(obj,t,n_c)
  end
  
end

