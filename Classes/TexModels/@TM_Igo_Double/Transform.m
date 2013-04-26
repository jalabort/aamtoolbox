function [igo_d_tex] = Transform(obj,img,n_img_ch)
  %TRANSFORM Summary of this function goes here
  %   Detailed explanation goes here
  
  fn_gx = zeros(obj.n_face_pixels2*n_img_ch,1);
  fn_gy = fn_gx;
  fn_gx2 = fn_gx;
  fn_gy2 = fn_gx;
  
  for i = 1:n_img_ch
    simg = obj.smoother.Run(img(:,:,i));
    [gx,gy] = gradient(simg);
    g_dir = angle(gx + 1i*gy);
    g_dir2 = 2 * g_dir;
    aux_x = cos(g_dir);
    aux_y = sin(g_dir);
    aux_x2 = cos(g_dir2);
    aux_y2 = sin(g_dir2); 
    ind = 1+obj.n_face_pixels2*(i-1):obj.n_face_pixels2*i;
    fn_gx(ind) = aux_x(obj.mask2);
    fn_gy(ind) = aux_y(obj.mask2);
    fn_gx2(ind) = aux_x2(obj.mask2);
    fn_gy2(ind) = aux_y2(obj.mask2);
  end
  
  igo_d_tex = [fn_gx;fn_gy;fn_gx2;fn_gy2] ./ (2*obj.n_face_pixels2).^(1/2);
  igo_d_tex(isnan(igo_d_tex)) = 0;
  igo_d_tex(isinf(igo_d_tex)) = 0;

end

