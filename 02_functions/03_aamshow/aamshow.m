function h = aamshow(i_fig,img,ann,parts,color)
  %aamshow Summary of this function goes here
  %   Detailed explanation goes here
  
  if nargin < 5
    color = 'green';
  end
  
  n_ann = size(ann,3);
  n_parts = length(parts);
  h = cell(n_parts,1);
  
  figure(i_fig);
  imshow(img,[]);
  hold on;
  h{1} = plot(ann(:,1,1),ann(:,2,1), ...
    '*', ...
    'MarkerFaceColor',color, ...
    'MarkerEdgeColor',color, ...
    'MarkerSize',3);
  for i = 2:n_parts
    h{i} = plot(ann(parts{i},1),ann(parts{i},2),color,'LineWidth',1);
  end
  for i = 2:n_ann
    set(h{1},'xData',ann(:,1,i));
    set(h{1},'yData',ann(:,2,i));
    for j = 2:n_parts
      set(h{j},'xData',ann(parts{j},1,i));
      set(h{j},'xData',ann(parts{j},2,i));
    end
  end
  hold off;

end

