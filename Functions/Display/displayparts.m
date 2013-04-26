function h = displayparts(i_fig,img,ann,parts,n_parts,color)
  %DISPLAYCOMP Summary of this function goes here
  %   Detailed explanation goes here
  
  h = figure(i_fig);
  imshow(img,[]);
  hold on;
  plot(ann(:,1),ann(:,2),'*','MarkerFaceColor',color,'MarkerEdgeColor',color, 'MarkerSize', 4);
  for i= 2:n_parts
    plot(ann(parts{i},1),ann(parts{i},2),color,'LineWidth',1);
  end
  axis off
  hold off;

end

