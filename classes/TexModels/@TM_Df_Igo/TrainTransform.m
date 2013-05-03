function [igo_tex] = TrainTransform(obj,img,n_img_ch)
  %TRAINTRANSFORM Summary of this function goes here
  %   Detailed explanation goes here
  
  fn_gx = zeros(obj.n_face_pixels*n_img_ch,1);
  fn_gy = zeros(obj.n_face_pixels*n_img_ch,1);
  
  for i = 1:n_img_ch
    %simg = obj.smoother.Run(img(:,:,i));
    simg = img;
    [~,g_dir] = imgradient(simg);
    aux_x = cosd(g_dir);
    aux_y = sind(g_dir);
    fn_gx(1+obj.n_face_pixels*(i-1):obj.n_face_pixels*i) = aux_x(obj.mask);
    fn_gy(1+obj.n_face_pixels*(i-1):obj.n_face_pixels*i) = aux_y(obj.mask);
  end
  
  igo_tex = [fn_gx;fn_gy] ./ sqrt(obj.n_face_pixels);

end

