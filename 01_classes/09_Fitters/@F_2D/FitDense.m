function [fann] = FitDense(obj,img,ann)
  %FitDense Summary of this function goes here
  %   Detailed explanation goes here
  
  fann = zeros([size(ann),obj.n_it]);
  img = obj.tm{1}.ColorTransformAll(img);
  [res(1),res(2),~] = size(img);
  
  aux1 = zeros(size(obj.w{obj.n_level}.rf.mask1));
  aux2 = aux1;
  xy = obj.w{obj.n_level}.Compute_Wuv(ann,res);
  aux1(obj.w{obj.n_level}.rf.uv_vec) = xy(:,1);
  aux2(obj.w{obj.n_level}.rf.uv_vec) = xy(:,2);
  xy(:,1) = aux1(obj.w{obj.n_level}.rf.mask1);
  xy(:,2) = aux2(obj.w{obj.n_level}.rf.mask1);
  ann = [ann;xy];
  
  [ann,detected,p] = obj.detector.Run(obj.sm{obj.n_level},img,ann);
  
  if detected
    
    n_it_level = ceil(obj.n_it / obj.n_level);
    it = 1;
    
    for i = obj.n_level:-1:1
           
      c = zeros(obj.tm{i}.n_c,1);
      
      aux1 = zeros(size(obj.w{i}.rf.mask1));
      aux2 = aux1;
      xy = obj.w{i}.Compute_Wuv(ann(1:obj.w{i}.rf.n_vert,:),res);
      aux1(obj.w{i}.rf.uv_vec) = xy(:,1);
      aux2(obj.w{i}.rf.uv_vec) = xy(:,2);
      xy(:,1) = aux1(obj.w{i}.rf.mask1);
      xy(:,2) = aux2(obj.w{i}.rf.mask1);
      ann = [ann(1:obj.w{i}.rf.n_vert,:);xy];
  
      [ann,p]  = obj.sm{i}.ProjectAnn(ann);

      for j = 1:n_it_level   

        wimg = obj.w{i}.WarpDense(ann,img);
        tex = obj.tm{i}.Transform(wimg);
        
        [delta,c] = obj.Optimize(i,j,tex,c,p);
        [ann,p] = obj.UpdateDenseAnn(i,ann,delta,p);
        
        fann(:,:,it) = ann(1:obj.w{1}.rf.n_vert,:); 
        it = it + 1;
        
      end
    end
  end
end

