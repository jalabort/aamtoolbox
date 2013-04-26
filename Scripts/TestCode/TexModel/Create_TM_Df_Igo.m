clear all
close all
clc

bin_root = '..\BinaryDataBases\';
type = 'Train';
name = ['LFPW-' type];
db = DB(name,bin_root);

id = 1:811;
reg_exp_query = db.RegExpQuery(id);
ds = db.Load(reg_exp_query);

ref_ann = ds.ComputeRefAnn();
n_vert = ds.n_vert;
parts = ds.parts;
n_parts = ds.n_parts;
erode = 4;
rf = RF(ref_ann,n_vert,parts,n_parts,erode);

tri = ds.tri;
n_tri = ds.n_tri;
w = W_PWA(rf,tri,n_tri,'bilinear');   
w = W_PWA_1(w);  

img = w.WarpDS(ds);
n_img = ds.n_data;
mask = rf.mask;
res = rf.res;
n_face_pixels = rf.n_face_pixels;
smoother = S_Med(3);
n_bin = 8;
tm = TM_Df_Igo(img,n_img,mask,res,n_face_pixels,smoother,n_bin);

c = tm.Tex2C(tm.pc(:,1),1);
img = tm.Tex2Img(tm.C2Tex(c)); 
for i =1:n_bin
  figure(i), imshow(img(:,:,i),[])
end

