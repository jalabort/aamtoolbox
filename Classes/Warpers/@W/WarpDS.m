function [img] = WarpDS(obj,ds)
  %WARPDS Summary of this function goes here
  %   Detailed explanation goes here
  
  img = zeros(obj.rf.res(1),obj.rf.res(2),ds.n_ch,ds.n_data);
  
  for i = 1:ds.n_data
    img_res = size(ds.data{i}.img);
    if length(img_res) == 3
      aux = double(ds.data{i}.img)./255;
    else
      aux = zeros(img_res(1),img_res(2),ds.n_ch);
      aux(:,:,1) = double(ds.data{i}.img)./255;
      aux(:,:,2) = aux(:,:,1);
      aux(:,:,3) = aux(:,:,1);
    end
    img(:,:,:,i) = obj.WarpOpt(ds.data{i}.ann,aux,img_res(1:2));
  end

end

