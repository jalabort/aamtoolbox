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

