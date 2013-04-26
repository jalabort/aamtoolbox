clear all
close all
clc


%% TestDataSet

bin_root = '..\BinaryDataBases\';
type = 'Test';
name = ['LFPW-' type];

db = DB(name,bin_root);

id = 1:100;

reg_exp_query = db.RegExpQuery(id);
ds = db.Load(reg_exp_query);

