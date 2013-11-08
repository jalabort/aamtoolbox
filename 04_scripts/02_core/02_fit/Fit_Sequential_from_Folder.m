for i = 1:n_fittings

  j = floor((i-1)/n_rand) + 1;

  % read image from input file
  img=imread([path data(j).name]);
  %ori = annread([path data2(j).name],test_db.n_vert);
  ori = [];

  [fit,ini,~] = f.FitSparse(img,ori);
  
  if fit ~= zeros(size(fit))
    fann(:,:,i) = fit(:,:,end);
    iann(:,:,i) = ini;
    %oann(:,:,i) = ori;

    % show the fitting
    if opt.show
%       if all(all(fit(:,:,end)))
%         h = 1;
%         aamshow(h,img,fit,test_db.parts);
%         drawnow
%       end
      % save images
      if opt.save_img
        [img,ann,~] = normalizefacesize(img,fit(:,:,end),f.sm{1});
        h=i;
        aamshow(h,img,ann,test_db.parts);
        drawnow
        print(h, '-dpng', '-opengl', [opt.img_root int2str(i) '.png']);
        %close all
      end
    end

    if opt.verbose 
      if all(all(fit(:,:,end)))
        [rms_err,p2p_err,ram_err,hel_err] = computeerr(fit(:,:,end), ...
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
    
end
