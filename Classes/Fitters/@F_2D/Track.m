function [tann,ecc] = Track(obj,img,ann)
  %TRACK Summary of this function goes here
  %   Detailed explanation goes here

  n_it_level = obj.n_it / obj.n_level;
  [cimg,n_img_ch] = obj.tm{1}.ColorTransformAll(img,1);
  cimg = cimg ./ 255;
  img_res = size(cimg);
  
  if isempty(ann)
    [ann,q,detected] = obj.face_det.Run(obj.sm{1},img,ann,obj.sm{1}.mu_ann,obj.sm{1}.n_vert,obj.w{1}.rf.res);
  else
    detected = true;
  end
  
  if detected
    
    if obj.show_fitting
      displayparts(1,img,ann,obj.w{1}.rf.parts,obj.w{1}.rf.n_parts,'red');
    end
    
    for i = obj.n_level:-1:1
           
      c = [];
      [ann,q,p,r]  = obj.sm{i}.ProjectAnn(ann);

      for j = 1:n_it_level   

        wimg = obj.w{i}.WarpOpt(ann,cimg,img_res);
        tex = obj.tm{i}.Transform(wimg,n_img_ch);
        
        [delta,c,~,ecc] = obj.Optimize(i,tex,c);
        [ann,q,p] = obj.w{i}.UpdateAnn(obj.sm{i},ann,delta,q,p,r);
         
        if obj.show_fitting
          displayparts(1,img,ann,obj.w{1}.rf.parts,obj.w{1}.rf.n_parts,'green');
        end

      end

    end
    
    tann = ann;
    
  else
    
    tann = nan(obj.sm{1}.n_vert,2);
    ecc = 0;
    
  end
  
end

