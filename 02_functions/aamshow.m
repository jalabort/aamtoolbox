function h = aamshow(i_fig,img,ann,parts)
  %aamshow Summary of this function goes here
  %   Detailed explanation goes here
  
  color = 'red';
  n_ann = size(ann,3);
  n_parts = length(parts);
  h = cell(n_parts,1);
  
  figure(i_fig);
  imshow(img,[]);
  hold on;
  h{1} = plot(ann(:,1,1),ann(:,2,1), ...
    'o', ...
    'MarkerFaceColor',color, ...
    'MarkerEdgeColor',color, ...
    'MarkerSize',3);
  for i = 2:n_parts
    h{i} = plot(ann(parts{i},1,1),ann(parts{i},2,1),color,'LineWidth',1);
  end
  pause(0.3)
  
  figure(i_fig);
  imshow(img,[]);
  hold on;
  color = 'green';
  h{1} = plot(ann(:,1,2),ann(:,2,2), ...
    'o', ...
    'MarkerFaceColor',color, ...
    'MarkerEdgeColor',color, ...
    'MarkerSize',3);
  for i = 2:n_parts
    h{i} = plot(ann(parts{i},1,2),ann(parts{i},2,2),color,'LineWidth',1);
  end
  for i = 3:n_ann
    set(h{1},'xData',ann(:,1,i));
    set(h{1},'yData',ann(:,2,i));
    for j = 2:n_parts
      set(h{j},'xData',ann(parts{j},1,i));
      set(h{j},'yData',ann(parts{j},2,i));
    end
    drawnow;
  end
  
  hold off;

end

