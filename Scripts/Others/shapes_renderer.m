weight = 20;
for i=[1:4]
    a = f.sm{1}.sim_mu;
    a(f.sm{1}.i_comp_shape{1}) = a(f.sm{1}.i_comp_shape{1}) + weight * f.sm{1}.comp_pc{1}(:,i);
    a(f.sm{1}.i_comp_shape{2}) = a(f.sm{1}.i_comp_shape{2}) + weight * f.sm{1}.comp_pc{2}(:,i);
    a(f.sm{1}.i_comp_shape{3}) = a(f.sm{1}.i_comp_shape{3}) + weight * f.sm{1}.comp_pc{3}(:,i);
    a(f.sm{1}.i_comp_shape{4}) = a(f.sm{1}.i_comp_shape{4}) + weight * f.sm{1}.comp_pc{4}(:,i);
    a(f.sm{1}.i_comp_shape{5}) = a(f.sm{1}.i_comp_shape{5}) + weight * f.sm{1}.comp_pc{5}(:,i);
    a(f.sm{1}.i_comp_shape{6}) = a(f.sm{1}.i_comp_shape{6}) + weight * f.sm{1}.comp_pc{6}(:,i);
    a(f.sm{1}.i_comp_shape{7}) = a(f.sm{1}.i_comp_shape{7}) + weight * f.sm{1}.comp_pc{7}(:,i);
    
    b = f.sm{1}.sim_mu;
    b(f.sm{1}.i_comp_shape{1}) = b(f.sm{1}.i_comp_shape{1}) - weight * f.sm{1}.comp_pc{1}(:,i);
    b(f.sm{1}.i_comp_shape{2}) = b(f.sm{1}.i_comp_shape{2}) - weight * f.sm{1}.comp_pc{2}(:,i);
    b(f.sm{1}.i_comp_shape{3}) = b(f.sm{1}.i_comp_shape{3}) - weight * f.sm{1}.comp_pc{3}(:,i);
    b(f.sm{1}.i_comp_shape{4}) = b(f.sm{1}.i_comp_shape{4}) - weight * f.sm{1}.comp_pc{4}(:,i);
    b(f.sm{1}.i_comp_shape{5}) = b(f.sm{1}.i_comp_shape{5}) - weight * f.sm{1}.comp_pc{5}(:,i);
    b(f.sm{1}.i_comp_shape{6}) = b(f.sm{1}.i_comp_shape{6}) - weight * f.sm{1}.comp_pc{6}(:,i);
    b(f.sm{1}.i_comp_shape{7}) = b(f.sm{1}.i_comp_shape{7}) - weight * f.sm{1}.comp_pc{7}(:,i);
    
    a = f.sm{1}.Shape2Ann(a);
    b = f.sm{1}.Shape2Ann(b);
    
    displayparts(1,[],a,test_ds.parts,test_ds.n_parts,'red')
    displayparts(2,[],b,test_ds.parts,test_ds.n_parts,'red')
    
    pause
    
    close all
end