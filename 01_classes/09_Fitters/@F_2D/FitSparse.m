function [fann,iann,oann] = FitSparse(obj,img,oann)
  %FitSparse Summary of this function goes here
  %   Detailed explanation goes here
  
  fann = zeros([size(obj.sm{1}.mu_ann),obj.n_it+1]);
  
  [iann,detected,~] = obj.detector.Run(obj.sm,img,oann);
  
  if detected
    
    [img,ann,scale] = normalizefacesize(img,iann,obj.sm{1});
    n_it_level = ceil(obj.n_it / obj.n_level);
    fann(:,:,1) = ann;
    it = 1;
    
    for i = obj.n_level:-1:1
      
      c = zeros(obj.tm{i}.n_c,1);
      [ann,p]  = obj.sm{i}.ProjectAnn(ann);
      [img_,ann_] = ComputeFeaturesSpace(obj,img,ann,i);
      
      for j = 1:n_it_level   
        
        wimg = obj.w{i}.WarpSparse(ann_,img_);
        tex = obj.tm{i}.Transform(wimg);
        
        [delta,c] = obj.Optimize(i,j,tex,c,p);
        [ann,p] = obj.UpdateSparseAnn(i,ann,delta,p);
        
        fann(:,:,it+1) = ann;
        ann_ = ann .* obj.tm{i}.factor;
        
        it = it + 1;
        
      end  
    end
    
    fann = fann ./ scale;
    
  end
end

