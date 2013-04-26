function [igo_tex] = Transform(obj,img,n_img_ch)
  %TRANSFORM Summary of this function goes here
  %   Detailed explanation goes here
  
  fn_gx = zeros(obj.n_face_pixels2*n_img_ch,1);
  fn_gy = fn_gx;
  
  for i = 1:n_img_ch
    simg = obj.smoother.Run(img(:,:,i));
    [gx,gy] = gradient(simg);
    g_dir = angle(gx + 1i*gy);
    aux_x = cos(g_dir);
    aux_y = sin(g_dir);
    ind = 1+obj.n_face_pixels2*(i-1):obj.n_face_pixels2*i;
    fn_gx(ind) = aux_x(obj.mask2);
    fn_gy(ind) = aux_y(obj.mask2);
  end
  
  igo_tex = [fn_gx;fn_gy] ./ sqrt(obj.n_face_pixels2);

end

