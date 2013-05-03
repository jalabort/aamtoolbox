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

ann = ds.getAnn();
n_vert = ds.n_vert;
n_ann = ds.n_data;
sm = SM_Pc(ann,n_vert,n_ann);

i_ann = 1;
n_p = 15;
rec_ann = sm.ProjectAnn(ann(:,:,i_ann),n_p);

err = mean(sqrt(sum((rec_ann - ann(:,:,i_ann)).^2,2)));
display(num2str(err));

