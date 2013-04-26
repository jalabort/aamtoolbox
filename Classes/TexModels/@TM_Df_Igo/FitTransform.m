function [df_tex] = FitTransform(obj,img,n_img_ch)
  %FITTRANSFORM Summary of this function goes here
  %   Detailed explanation goes here
  
  gdir_tex = zeros(n_img_ch*obj.n_face_pixels,1);
  one = ones(n_img_ch*obj.n_face_pixels,1);
  df_tex = zeros(obj.n_bin*n_img_ch*obj.n_face_pixels,1);

  for i = 1:n_img_ch 
    simg = obj.smoother.Run(img(:,:,i));
    [~,gdir] = imgradient(simg);
    gdir_tex(1+obj.n_face_pixels*(i-1):obj.n_face_pixels*i) = gdir(obj.mask);
  end
  
  for i = 1:obj.n_bin    
    i_bin = find(gdir_tex > obj.bin(i) & gdir_tex < obj.bin(i+1));
    df_tex(obj.n_face_pixels*(i-1)+i_bin) = one(i_bin); 
  end
  
  aux = obj.Tex2Img(df_tex);
  aux = obj.smoother.Run(aux);
  df_tex = obj.Img2Tex(aux);
    
end

