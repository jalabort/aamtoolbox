path = 'C:\Users\Joan\Desktop\FacialFeatureDetection&Tracking_v12\FacialFeatureDetection&Tracking_v12\data\afw\';
ext = '.jpg';
ext2 = '.pts';
data = dir([path '*' ext]);
data2 = dir([path '*' ext2]);

fann = zeros(train_db.n_vert,2,n_fittings);
oann = fann;
iann = fann;

parfor i = 1:n_fittings

  j = floor((i-1)/n_rand) + 1;
  
  % read image from input file
  img=imread([path data(j).name]);
  fitt = annread([path data2(j).name],68);
  
  [fit,ini,ori] = f.FitSparse(img,fitt);
  fann(:,:,i) = fit(:,:,end);
  iann(:,:,i) = ini(:,:,end);
  oann(:,:,i) = ori(:,:,end);
  
  % show the fitting
  if 0
    if all(all(fit(:,:,end)))
      h = 1;
      aamshow(h,img,fit,test_db.parts);
    end
  end
  
  if 1 
    if all(all(fit(:,:,end)))
      [rms_err,p2p_err,ram_err,hel_err] = computeerr(fit(:,:,end), ...
        fitt, ...
        fitt, ...
        test_db.comp);
      fprintf(['  - img: ' int2str(j) '/' int2str(test_ds.n_data) ...
        '\t\t  rms_err: ' num2str(rms_err) ...
        '\t  p2p_err: ' num2str(p2p_err) ...
        '\t  ram_err: ' num2str(ram_err) ...
        '\t  hel_err: ' num2str(hel_err) ...
        '\n']);
    else
      fprintf([' - image: ' int2str(j) '/' int2str(test_ds.n_data) ...
        '\t face not detected!' ...
        '\n']);
    end
  end

end

