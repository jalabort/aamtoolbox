function [df_tex,aux] = C2Tex(obj,c)
  %C2TEX Summary of this function goes here
  %   Detailed explanation goes here

  igo_tex = obj.pca.Coeff2Data(obj.mu,obj.pc(:,1:length(c)),c);
  
  gdir_tex = zeros(0.5*obj.n_ch*obj.n_face_pixels,1);
  one = ones(0.5*obj.n_ch*obj.n_face_pixels,1);
  df_tex = zeros(obj.n_bin*0.5*obj.n_ch*obj.n_face_pixels,1);
  
  for i = 1:2:obj.n_ch
    x = getTexCh(obj,igo_tex,i);
    y = getTexCh(obj,igo_tex,i+1);
    gdir_tex(1+obj.n_face_pixels*(i-1):obj.n_face_pixels*i) = atan2d(y,x);
  end
  
  for i = 1:obj.n_bin    
    i_bin = find(gdir_tex > obj.bin(i) & gdir_tex < obj.bin(i+1));
    df_tex(obj.n_face_pixels*(i-1)+i_bin) = one(i_bin); 
  end
  
  aux = obj.Tex2Img(df_tex);
  aux = obj.smoother.Run(aux);
  df_tex = obj.Img2Tex(aux);
  
  aux = [];

end

