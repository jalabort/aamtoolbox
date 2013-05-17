function [gi_tex] = Transform(obj,img,n_img_ch)
  %TRANSFORM Summary of this function goes here
  %   Detailed explanation goes here
  
  fn_gx = zeros(obj.n_face_pixels2*n_img_ch,1);
  fn_gy = fn_gx;
  
  for i = 1:n_img_ch
    simg = obj.smoother.Run(img(:,:,i));
    [gx,gy] = gradient(simg);
    aux = gx + 1i*gy;
    g_dir = angle(aux);
    g_mag = abs(aux);
    aux_x = cos(g_dir);
    aux_y = sin(g_dir);
    med = median(g_mag(obj.mask2));
    ng_mag = g_mag(obj.mask2) + med;
    ind = 1+obj.n_face_pixels2*(i-1):obj.n_face_pixels2*i;
    fn_gx(ind) = aux_x(obj.mask2) ./ ng_mag;
    fn_gy(ind) = aux_y(obj.mask2) ./ ng_mag;
  end
  
  gi_tex = [fn_gx;fn_gy];

end

