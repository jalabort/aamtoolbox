function [fann] = Fit(obj,datum)
  %FIT Summary of this function goes here
  %   Detailed explanation goes here
  
  n_it_level = obj.n_it / obj.n_level;
  [cimg,n_img_ch] = obj.tm{1}.ColorTransformAll(datum.img,1);
  cimg = cimg ./ 255;
  img_res = size(cimg);
  
  [ann,q,detected] = obj.face_det.Run(obj.sm{1},datum.img,datum.ann,obj.sm{1}.mu_ann,obj.sm{1}.n_vert,obj.w{1}.rf.res);
  
  if detected
    
    if obj.show_fitting
      displayparts(1,datum.img,ann,obj.w{1}.rf.parts,obj.w{1}.rf.n_parts,'red');
    end
    
    % ---------------------------------------------------------------------
    
%     p = zeros(obj.sm{obj.n_level}.n_p,1);
%     n_p_prev = obj.sm{obj.n_level}.n_p;
%     
%     r = cell(obj.sm{obj.n_level}.n_comp,1);
%     n_r_prev = zeros(obj.sm{obj.n_level}.n_comp,1);
%     for k = 1:obj.sm{obj.n_level}.n_comp
%       r{k} = zeros(obj.sm{obj.n_level}.n_r(k),1);
%       n_r_prev(k) = obj.sm{obj.n_level}.n_r(k);
%     end
    
p=[];
r=[];
    
    % ---------------------------------------------------------------------
    
    for i = obj.n_level:-1:1
           
      c = [];
      %[ann]  = obj.sm{i}.ProjectAnn(ann);
      
      % ---------------------------------------------------------------------
      
%       p = [p;zeros(obj.sm{i}.n_p - n_p_prev,1)];
%       n_p_prev = obj.sm{i}.n_p;
%       
%       for k = 1:obj.sm{i}.n_comp
%         r{k} = [r{k};zeros(obj.sm{i}.n_r(k)-n_r_prev(k),1)];
%         n_r_prev(k) = obj.sm{i}.n_r(k);
%       end
      
      % ---------------------------------------------------------------------

      for j = 1:n_it_level   

        wimg = obj.w{i}.WarpOpt(ann,cimg,img_res);
        tex = obj.tm{i}.Transform(wimg,n_img_ch);
        
        [delta,c,H] = obj.Optimize(i,tex,c);
        [ann,q,p,r] = obj.w{i}.UpdateAnn(obj.sm{i},ann,delta,q,p,r,H);
        
        if obj.show_fitting
          displayparts(1,datum.img,ann,obj.w{1}.rf.parts,obj.w{1}.rf.n_parts,'green');
        end

      end

    end

    fann = ann;
    
  else
    
    fann = nan(obj.sm{1}.n_vert,2);  
    
  end

end

