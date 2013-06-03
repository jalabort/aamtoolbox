function [fann] = Fit(obj,img,ann)
  %Fit Summary of this function goes here
  %   Detailed explanation goes here
  
  fann = zeros([size(obj.sm{1}.mu_ann),obj.n_it]);
  img = obj.tm{1}.ColorTransformAll(img);
  
  [ann,detected,p] = obj.detector.Run(obj.sm{obj.n_level},img,ann);
  
  if detected
    
    n_it_level = ceil(obj.n_it / obj.n_level);
    it = 1;
    
    for i = obj.n_level:-1:1
           
      c = [];
      [ann,p]  = obj.sm{i}.ProjectAnn(ann);

      for j = 1:n_it_level   

        wimg = obj.w{i}.Warp(ann,img);
        tex = obj.tm{i}.Transform(wimg);
        
        [delta,c] = obj.Optimize(i,tex,c,p);
        [ann,p] = obj.UpdateAnn(i,ann,delta,p);
        
        fann(:,:,it) = ann; 
        it = it + 1;
        
      end
    end
  end
end

