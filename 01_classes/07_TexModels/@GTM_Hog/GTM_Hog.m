classdef GTM_Hog < GTM
  %GTM_Hog Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    pca = PCA_Cent();
    n_ch_features = 9
    cell_size = 1
  end
  
  methods
    function obj = GTM_Hog(img,rf,smoother,cell_size,n_orientation)
      obj@GTM(img,rf,smoother);
      obj.cell_size = cell_size;
      obj.n_ch_features = n_orientation;
    end
  end

end

