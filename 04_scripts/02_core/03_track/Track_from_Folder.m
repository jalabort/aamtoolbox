display('- tracking');

% read folder
data = dir([path '*.' img_type]);
n_fittings =  length(data);

fann = zeros(train_db.n_vert,2,n_fittings);
iann = fann;
oann = fann;

ini = annread([path data(1).name(1:strfind(data(1).name,'.')) ann_type],68);

for i = 1:n_fittings

  % read image from input file
  img = imread([path data(i).name]);
  ori = annread([path data(i).name(1:strfind(data(i).name,'.')) ann_type],68);

  [fit] = f.TrackSparse(img,ini);
  fann(:,:,i) = fit(:,:,end);
  oann(:,:,i) = ori;
  ini = fit(:,:,end);
  
  % show the fitting
  if opt.show
    if all(all(fit(:,:,end)))
      h = 1;
      aamshow(h,img,fit,test_db.parts);
      drawnow
    end
    % save images
    if opt.save_img
      frame = getframe(h);
      imwrite(frame.cdata,[opt.img_root int2str(i)],'png'); 
    end
  end

  if opt.verbose 
    if all(all(fit(:,:,end)))
      [rms_err,p2p_err,ram_err,hel_err] = computeerr(fit(:,:,end), ...
        ori, ...
        ori, ...
        test_db.comp);
      fprintf(['  - img: ' int2str(i) '/' int2str(test_db.n_data) ...
        '\t\t  rms_err: ' num2str(rms_err) ...
        '\t  p2p_err: ' num2str(p2p_err) ...
        '\t  ram_err: ' num2str(ram_err) ...
        '\t  hel_err: ' num2str(hel_err) ...
        '\n']);
    else
      fprintf([' - image: ' int2str(i) '/' int2str(test_db.n_data) ...
        '\t face not detected!' ...
        '\n']);
    end
  end
    
end


% save fitted ann
if opt.save_ann
  saveann(opt,fann);
end

