function [euler_tex] = Transform(obj,img,n_img_ch)
  %TRANSFORM Summary of this function goes here
  %   Detailed explanation goes here
  
  fn_r = zeros(obj.n_face_pixels2*n_img_ch,1);
  fn_i = fn_r;
  fn_r2 = fn_r;
  fn_i2 = fn_r;
  
  for i = 1:n_img_ch
    simg = obj.smoother.Run(img(:,:,i));
    g_dir = simg * obj.alpha_pi;
    ind = 1+obj.n_face_pixels2*(i-1):obj.n_face_pixels2*i;
    fn_r(ind) = cos(g_dir(obj.mask2));
    fn_i(ind) = sin(g_dir(obj.mask2));
    fn_r2(ind) = cos(2*g_dir(obj.mask2));
    fn_i2(ind) = sin(2*g_dir(obj.mask2));
  end
  
  euler_tex = [fn_r;fn_i;fn_r2;fn_i2] ./ obj.n_face_pixels2.^(1/4);

end

