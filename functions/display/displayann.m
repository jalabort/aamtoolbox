function h = displayann(i_fig,ann,parts,n_parts,color)
  %DISPLAYCOMP Summary of this function goes here
  %   Detailed explanation goes here
  
  h = figure(i_fig);
  plot(ann(:,1),-ann(:,2),'o','MarkerFaceColor',color,'MarkerEdgeColor',color, 'MarkerSize', 2);
  hold on;
  for i= 2:n_parts
    plot(ann(parts{i},1),-ann(parts{i},2),color,'LineWidth',1);
  end
  hold off;

end

