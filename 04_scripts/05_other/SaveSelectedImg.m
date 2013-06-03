opt.img_root = ['.' filesep];
sym_color = {'r*','b*','g*'};

for j = 1:f.n_level
  for i = [5,7,15,21,49,52,64,79,88,146,174,188,208,236,287,289,303,320,322]

    figure(1)
    imshow(test_ds.data{i}.img,[]);
    hold on
    plot(rann(:,1,1,i),rann(:,2,j,i),sym_color{j});
    hold off

    frame = getframe(h);
    imwrite(frame.cdata,[opt.img_root cell2mat(opt.m.shape_model) ...
      '_' int2str(j) '_' int2str(i)],'png');

  end
end