function [img,ann] = ComputeFeaturesSpace(obj,img,ann,i)
  %ComputeFeatures Summary of this function goes here
  %   Detailed explanation goes here

  [img,ann] = scaleimg(img,ann,obj.tm{i}.factor,obj.smoother{i});
  
  if size(img,3) == 3
    img = rgb2gray(img);
  end

  % compute features if necessary
  switch obj.tm{i}.feature_type
    case 'igo'
      img = img2igo(img);
    case 'igo-double'
      img = img2igodouble(img,alpha);
    case 'gi'
      img = img2gidouble(img,alpha);
    case 'gi-double'
      img = img2gidouble(img,alpha);
    case 'euler'
      img = img2euler(img,alpha);
    case 'euler-double'
      img = img2eulerdouble(img,alpha);
  end

end

