function [wimg] = Warp3ChOptM(obj,ann,img,img_res)
  %WARP3CHOPTM Summary of this function goes here
  %   Detailed explanation goes here

  img1 = img(:,:,1);
  img2 = img(:,:,2);
  img3 = img(:,:,3);
  wimg1 = zeros(obj.rf.res);
  wimg2 = zeros(obj.rf.res);
  wimg3 = zeros(obj.rf.res);
  max_ind_img = img_res(1) * img_res(2);

  for i = 1:obj.n_tri
    
    x = ann(obj.tri(i,:),1);
    y = ann(obj.tri(i,:),2);

    if ~isempty(obj.alphas{i}) && ~isempty(obj.betas{i}) && ~isempty(obj.gammas{i})

      target_x = x(1) * obj.gammas{i} + x(2) * obj.alphas{i} + x(3) * obj.betas{i};
      target_y = y(1) * obj.gammas{i} + y(2) * obj.alphas{i} + y(3) * obj.betas{i};

      switch obj.interp

        case 'none'
          
          ind_img = round(target_y) + (round(target_x) - 1) * img_res(1);
          list = ind_img > 0 & ind_img <= max_ind_img;
          ind_img = ind_img(list);
          obj.ind_base{i} = obj.ind_base{i}(list);

          wimg1(obj.ind_base{i}) = img1(ind_img);
          wimg2(obj.ind_base{i}) = img2(ind_img);
          wimg3(obj.ind_base{i}) = img3(ind_img);

        case 'bilinear'

          floor_tx = floor(target_x);
          floor_ty = floor(target_y);
          delta_x = target_x - floor_tx;
          delta_y = target_y - floor_ty;
          
          mult1 = (1-delta_x) .* (1-delta_y);
          mult2 =   delta_x   .* (1-delta_y);
          mult3 = (1-delta_x) .*   delta_y  ;
          mult4 =   delta_x   .*   delta_y  ;
          
          ind1 =   floor_ty   + (floor_tx-1) * img_res(1);
          ind2 =   floor_ty   +   floor_tx   * img_res(1);
          ind3 = (floor_ty+1) + (floor_tx-1) * img_res(1);
          ind4 = (floor_ty+1) +   floor_tx   * img_res(1);
          
          list = ind1 > 0 & ind1 <= max_ind_img & ind2 > 0 & ind2 <= max_ind_img & ind3 > 0 & ind3 <= max_ind_img & ind4 > 0 & ind4 <= max_ind_img;
          mult1 = mult1(list);
          mult2 = mult2(list);
          mult3 = mult3(list);
          mult4 = mult4(list);
          ind1 = ind1(list);
          ind2 = ind2(list);
          ind3 = ind3(list);
          ind4 = ind4(list);
          obj.ind_base{i} = obj.ind_base{i}(list);
          
          wimg1(obj.ind_base{i}) =  mult1 .* img1(ind1) +...
                                    mult2 .* img1(ind2) +...
                                    mult3 .* img1(ind3) +...
                                    mult4 .* img1(ind4);
                                      
          wimg2(obj.ind_base{i}) =  mult1 .* img2(ind1) +...
                                    mult2 .* img2(ind2) +...
                                    mult3 .* img2(ind3) +...
                                    mult4 .* img2(ind4);
                                      
          wimg3(obj.ind_base{i}) =  mult1 .* img3(ind1) +...
                                    mult2 .* img3(ind2) +...
                                    mult3 .* img3(ind3) +...
                                    mult4 .* img3(ind4);

      end

    end
    
  end
  
  wimg(:,:,1) = wimg1;
  wimg(:,:,2) = wimg2;
  wimg(:,:,3) = wimg3;

end

