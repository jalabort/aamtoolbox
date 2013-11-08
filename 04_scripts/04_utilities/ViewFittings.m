% options
opt.show = true;
opt.print_img = true;
opt.verbose = true;

for i = 1:n_fittings

  j = floor((i-1)/n_rand) + 1;

  % read image from input file
  img=imread([path data(j).name]);
  ori = annread([path data2(j).name],test_db.n_vert);

  % show the fitting
  if opt.show
    if all(all(fann(:,:,i)))
      h = 1;
      aamshow(h,img,fann(:,:,i),test_db.parts);
      drawnow
      % print images
      if opt.print_img
        print(h, '-dpng', '-r1000', '-opengl', [opt.img_root int2str(i) '.png']);
      end
    end
  end

  % verbose
  if opt.verbose 
    if all(all(fann(:,:,i)))
      [rms_err,p2p_err,ram_err,hel_err] = computeerr(fann(:,:,i), ...
        ori, ...
        ori, ...
        test_db.comp);
      fprintf(['  - img: ' int2str(j) '/' int2str(test_db.n_data) ...
        '\t\t  rms_err: ' num2str(rms_err) ...
        '\t  p2p_err: ' num2str(p2p_err) ...
        '\t  ram_err: ' num2str(ram_err) ...
        '\t  hel_err: ' num2str(hel_err) ...
        '\n']);
    else
      fprintf([' - image: ' int2str(j) '/' int2str(test_db.n_data) ...
        '\t face not detected!' ...
        '\n']);
    end
  end
    
end
