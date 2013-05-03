function [euler_tex] = Transform(obj,img,n_img_ch)
  %TRANSFORM Summary of this function goes here
  %   Detailed explanation goes here
  
  fn_g = zeros(obj.n_face_pixels*n_img_ch,1);
  
  for i = 1:n_img_ch
    simg = obj.smoother.Run(img(:,:,i));
    g_dir = (simg - 05) * obj.alpha_pi;
    fn_g(1+obj.n_face_pixels*(i-1):obj.n_face_pixels*i) = exp(1i*g_dir(obj.mask));
  end
  
  euler_tex = fn_g ./ sqrt(obj.n_face_pixels);

end

