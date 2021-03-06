clear all
close all
clc


%% Test GTM_Gi_Real

disp('- Test GTM_Gi_Real test');

% specify database
bin_root = ['..' ...
  filesep 'binarydb' ...
  filesep];
name = 'lfpw';
type = 'train';
ann = 'our';
db = DB([name '-' type '-' ann],bin_root);

% number of image
n_data = 100;

% get dataset
id = 1:n_data;
reg_exp_query = db.RegExpQuery(id);
ds = db.Load(reg_exp_query);

% create RF reference frame
ref_ann = ds.ComputeRefAnn(); 
parts = ds.parts; 
erode1 = 1; 
erode2 = 2;
rf = RF(ref_ann,parts,erode1,erode2);

% create W_TPS warper
interp = 'linear';
w = W_TPS(rf,interp);

% create Test GTM_Gi texture model
img = TM.ColorTransformAll(w.WarpDS(ds));
smoother = [];
tm = GTM_Gi_Real(img,rf,smoother);

% visualize model (this just makes sure the model can be correctly 
% visualized, for careful inpection each eigenvector should be plot
% using imshow(tm.Tex2Img(tm.pc(:,i),[]))
aux = tm.Tex2Img(tm.mu);
figure(1);
imshow(aux(:,:,1),[]);
figure(2);
imshow(aux(:,:,2),[]);
aux = tm.Tex2Img(tm.pc(:,1));
figure(1);
h1 = imshow(aux(:,:,1),[]);
set(h1,'EraseMode','none');
figure(2);
h2 = imshow(aux(:,:,2),[]);
set(h2,'EraseMode','none');
for i = 2:tm.n_pc
  aux = tm.Tex2Img(tm.pc(:,i));
  set(h1,'CData',aux(:,:,1));
  set(h2,'CData',aux(:,:,2));
  drawnow;
end

% test
assert(tm.n_pixels == tm.res(1) * tm.res(2) && ...
  tm.n_pixels>tm.n_face_pixels1 && ...
  tm.n_face_pixels1>tm.n_face_pixels2 && ... 
  tm.n_ch == tm.n_ch_img * tm.n_ch_features && ...
  tm.n_face_features == tm.n_face_pixels1 * tm.n_ch_features && ...
  tm.n_pc == size(tm.pc,2) && ...
  tm.n_pc == tm.n_c)
disp('  passed');


%% Test GTM_Gi_Complex

disp('- Test GTM_Gi_Complex test');

% create Test GTM_Gi texture model
tm = GTM_Gi_Complex(img,rf,smoother);

% visualize model (this just makes sure the model can be correctly 
% visualized, for careful inpection each eigenvector should be plot
% using imshow(tm.Tex2Img(tm.pc(:,i),[]))
aux = tm.Tex2Img(tm.mu);
figure(1);
imshow(real(aux),[]);
figure(2);
imshow(imag(aux),[]);
aux = tm.Tex2Img(tm.pc(:,1));
figure(1);
h1 = imshow(real(aux),[]);
set(h1,'EraseMode','none');
figure(2);
h2 = imshow(imag(aux),[]);
set(h2,'EraseMode','none');
for i = 2:tm.n_pc
  aux = tm.Tex2Img(tm.pc(:,i));
  set(h1,'CData',real(aux));
  set(h2,'CData',imag(aux));
  drawnow;
end

% test
assert(tm.n_pixels == tm.res(1) * tm.res(2) && ...
  tm.n_pixels>tm.n_face_pixels1 && ...
  tm.n_face_pixels1>tm.n_face_pixels2 && ... 
  tm.n_ch == tm.n_ch_img * tm.n_ch_features && ...
  tm.n_face_features == tm.n_face_pixels1 * tm.n_ch_features && ...
  tm.n_pc == size(tm.pc,2) && ...
  tm.n_pc == tm.n_c)
disp('  passed');

