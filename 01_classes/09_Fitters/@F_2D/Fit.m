function [fann] = Fit(obj,img,ann)
  %FIT Summary of this function goes here
  %   Detailed explanation goes here
  
  fann = zeros([size(obj.sm{1}.mu_ann),obj.n_it]);
  img = obj.tm{1}.ColorTransformAll(img);
  
  [ann,detected,p] = obj.detector.Run(obj.sm{1},img,ann);
  
  if detected
    
    n_it_level = obj.n_it / obj.n_level;
    it = 0;
    
    for i = obj.n_level:-1:1
           
      c = [];
      ann  = obj.sm{i}.ProjectAnn(ann);

      for j = 1:n_it_level   

        wimg = obj.w{i}.Warp(ann,img);
        tex = obj.tm{i}.Transform(wimg);
        
        [delta,c] = obj.Optimize(i,tex,c);
        [ann,p] = obj.w{i}.UpdateAnn(obj.sm{i},ann,delta,p);
        
        fann(:,:,it) = ann; 
        it = it + 1;
        
      end

    end
    
  end

end

