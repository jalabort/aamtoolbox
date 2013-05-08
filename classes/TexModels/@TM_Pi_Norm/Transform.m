function [pi_tex] = Transform(obj,img,n_img_ch)
  %TRANSFORM Summary of this function goes here
  %   Detailed explanation goes here
  
  nimg = zeros(obj.n_face_pixels2*n_img_ch,1);

  for i = 1:n_img_ch
    simg = obj.smoother.Run(img(:,:,i));
    nimg(1+obj.n_face_pixels2*(i-1):obj.n_face_pixels2*i) = simg(obj.mask2) - mean(simg(obj.mask2));
  end
  
  pi_tex = nimg ./ norm(nimg);
  pi_tex(isnan(pi_tex)) = 0;
  pi_tex(isinf(pi_tex)) = 0;

end

