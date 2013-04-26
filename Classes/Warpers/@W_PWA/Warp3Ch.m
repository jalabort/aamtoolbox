function [warpedImg] = Warp3Ch(obj,ann,img,imgRes)
  %WARP3CH Summary of this function goes here
  %   Detailed explanation goes here

  img1 = img(:,:,1);
  img2 = img(:,:,2);
  img3 = img(:,:,3);
  warpedImg1 = zeros(obj.refFrame.res);
  warpedImg2 = zeros(obj.refFrame.res);
  warpedImg3 = zeros(obj.refFrame.res);
  maxIndImg = imgRes(1) * imgRes(2);
  a = zeros(1,6);

  for i = 1:obj.nTri
    
    X = ann(obj.tri(i,:),1);
    Y = ann(obj.tri(i,:),2);

    x2x1 = X(2) - X(1);
    x3x1 = X(3) - X(1);
    y2y1 = Y(2) - Y(1);
    y3y1 = Y(3) - Y(1);
    
    a(1) = X(1) + (obj.num1{i} * x2x1 + obj.num2{i} * x3x1) / obj.den{i};
    a(2) = (obj.v3v1{i} * x2x1 - obj.v2v1{i} * x3x1) / obj.den{i};
    a(3) = (obj.u2u1{i} * x3x1 - obj.u3u1{i} * x2x1) / obj.den{i};

    a(4) = Y(1) + (obj.num1{i} * y2y1 + obj.num2{i} * y3y1) / obj.den{i};
    a(5) = (obj.v3v1{i} * y2y1 - obj.v2v1{i} * y3y1) / obj.den{i};
    a(6) = (obj.u2u1{i} * y3y1 - obj.u3u1{i} * y2y1) / obj.den{i};

    if ~isempty(obj.v{i}) && ~isempty(obj.u{i})

      targetX = a(1) + a(2) .* obj.u{i} + a(3) .* obj.v{i};
      targetY = a(4) + a(5) .* obj.u{i} + a(6) .* obj.v{i};

      switch obj.interp

        case 'none'
          
          indImg = round(targetY) + (round(targetX) - 1) * imgRes(1);
          list = indImg > 0 & indImg <= maxIndImg;
          indImg = indImg(list);
          obj.indBase{i} = obj.indBase{i}(list);

          warpedImg1(obj.indBase{i}) = img1(indImg);
          warpedImg2(obj.indBase{i}) = img2(indImg);
          warpedImg3(obj.indBase{i}) = img3(indImg);

        case 'bilinear'

          floorTX = floor(targetX);
          floorTY = floor(targetY);
          delta_x = targetX - floorTX;
          delta_y = targetY - floorTY;
          
          mult1 = (1-delta_x) .* (1-delta_y);
          mult2 =   delta_x   .* (1-delta_y);
          mult3 = (1-delta_x) .*   delta_y  ;
          mult4 =   delta_x   .*   delta_y  ;
          
          ind1 =   floorTY   + (floorTX-1) * imgRes(1);
          ind2 =   floorTY   +   floorTX   * imgRes(1);
          ind3 = (floorTY+1) + (floorTX-1) * imgRes(1);
          ind4 = (floorTY+1) +   floorTX   * imgRes(1);
          
          list = ind1 > 0 & ind1 <= maxIndImg & ind2 > 0 & ind2 <= maxIndImg & ind3 > 0 & ind3 <= maxIndImg & ind4 > 0 & ind4 <= maxIndImg;
          mult1 = mult1(list);
          mult2 = mult2(list);
          mult3 = mult3(list);
          mult4 = mult4(list);
          ind1 = ind1(list);
          ind2 = ind2(list);
          ind3 = ind3(list);
          ind4 = ind4(list);
          obj.indBase{i} = obj.indBase{i}(list);
          
          warpedImg1(obj.indBase{i}) =  mult1 .* img1(ind1) +...
                                        mult2 .* img1(ind2) +...
                                        mult3 .* img1(ind3) +...
                                        mult4 .* img1(ind4);
                                      
          warpedImg2(obj.indBase{i}) =  mult1 .* img2(ind1) +...
                                        mult2 .* img2(ind2) +...
                                        mult3 .* img2(ind3) +...
                                        mult4 .* img2(ind4);
                                      
          warpedImg3(obj.indBase{i}) =  mult1 .* img3(ind1) +...
                                        mult2 .* img3(ind2) +...
                                        mult3 .* img3(ind3) +...
                                        mult4 .* img3(ind4);


      end

    end
    
  end
  
  warpedImg(:,:,1) = warpedImg1;
  warpedImg(:,:,2) = warpedImg2;
  warpedImg(:,:,3) = warpedImg3;

end

