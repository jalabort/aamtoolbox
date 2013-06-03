display('- Creating fitter');
  
switch opt.algorithm
  case 'pic-ssd'
    f = F_PicSsd(m);
  case 'pic-ecc'
    f = F_PicEcc(m);
  case 'aic-ssd'
    f = F_AicSsd(m);
  case 'aic-ecc'
    f = F_AicEcc(m);
  case 'sic-ssd'
    f = F_SicSsd(m);
  case 'sic-ecc'
    f = F_SicEcc(m);
end
clear m

if strcmp(opt.m.warp,'pwa')
  switch opt.composition 
    case 'baker'
      for i = 1:f.n_level
        f.w{i} = W_PWA_1(f.w{i});
      end
    case 'papandreou'
      for i = 1:f.n_level
        f.w{i} = W_PWA_2(f.w{i});
      end
  end
end

switch opt.m.tex_model 
  case 'df-igo'
    for i = 1:f.n_level
      f.tm{i}.n_bin = opt.n_bin{i};
      f.tm{i}.bin = f.tm{i}.SetBin();
      siz = 2*opt.sigma{i}+1;
      H = fspecial3('gaussian',[siz siz siz],opt.sigma{i});
      f.tm{i}.smoother.H = H;
    end
end

switch opt.face_detector 
  case 'gr-tr'
    f.face_det = FD_GrTr();
  case 'matlab'
    f.face_det = FD_Mat();
end

for i = 1:f.n_level
  f.tm{i}.n_c = opt.n_c{i};
  if strcmp(opt.m.shape_model{i}(1:2),'cb')
    f.sm{i}.n_p = opt.n_p2{i};
    f.sm{i}.n_r = [opt.n_r{:,i}];
    f.sm{i}.n_qpr = f.sm{i}.n_q + opt.n_p2{i} + sum([opt.n_r{:,i}]);
  else
    f.sm{i}.n_p = opt.n_p1{i};
    f.sm{i}.n_qpr = f.sm{i}.n_q  + opt.n_p1{i};
  end
end

f.n_it = opt.n_it;
f.show_fitting = opt.show_fitting;

display('- Initializing fitter');

f = f.Initialize();

display('- Tracking');

data = dir([opt.folder opt.sequence '*' opt.img_ext]);
n_data = length(data);

t_anns = zeros(train_db.n_vert,2,n_data);
ecc = 0;

for i = 1:n_data

  %img = imread([opt.folder opt.sequence data(i).name]);
  img = a(:,:,:,i);
  
  if ecc < 0.05
    ann = [];
  end 
  
  [ann,ecc] = f.Track(img,ann);
  t_anns(:,:,i) = ann;
  
  disp([' - Image: ' int2str(i) '/' int2str(n_data) '\t ecc: ' num2str(ecc)]);
  displayparts(1,img,t_anns(:,:,i),train_db.parts,train_db.n_parts,'green');
  
end

if opt.create_video
  
  writerObj = VideoWriter([opt.folder opt.sequence 'vid.avi']);
  writerObj.FrameRate =  xyloObj.FrameRate;
  writerObj.Quality = 100;
  open(writerObj)

  for k = 1:200
%     img = imread([opt.folder opt.sequence data(k).name]);
    img = a(:,:,:,k);
    displayparts(1,img,t_anns(:,:,k),train_db.parts,train_db.n_parts,'green');
    frame = getframe;
    writeVideo(writerObj,frame);
  end

  close(writerObj);
  
end
  

