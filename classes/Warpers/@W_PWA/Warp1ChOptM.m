function [wimg] = Warp1ChOptM(obj,ann,img,img_res)
  %WARP1CHOPM Summary of this function goes here
  %   Detailed explanation goes here

  wimg = zeros(obj.rf.res);
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
          
          wimg(obj.ind_base{i}) = img(ind_img);

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
          
          wimg(obj.ind_base{i}) =  mult1 .* img(ind1) +...
                                   mult2 .* img(ind2) +...
                                   mult3 .* img(ind3) +...
                                   mult4 .* img(ind4);
      end

    end
    
  end

end

