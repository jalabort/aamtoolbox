figure(1)
% hold on
set(gca, 'FontSize', 0.05)
set(gca, 'FontWeight', 'bold')
ytick = 0:0.1:1;
set(gca, 'ytick', ytick);
limit = 0.2;
xtick = 0:0.02:limit;
set(gca, 'xtick', xtick);
ylabel('Proportion of Images', 'Interpreter', 'tex', 'fontsize', 15)
xlabel('Shape RMSE', 'Interpreter', 'tex', 'fontsize', 15)
title('LFPW','Interpreter', 'tex', 'fontsize', 15)
grid on

error = zeros(i,1);

for j = 1:i
  temp1 = test_ds.data{j}.ann;
  temp2 = fann(:,:,j);
  eye1 = mean(temp1(test_ds.comp{3},:));
  eye2 = mean(temp1(test_ds.comp{4},:));
  eye_dist = mean(sqrt(sum((eye1 - eye2).^2,2)));
%   eye_dist = mean(sqrt(sum((temp1(125,:) - temp2(145,:)).^2,2)));
  error(j) = mean(sqrt(sum((temp1 - temp2).^2,2))) / eye_dist;
end

list = 0:0.0005:limit;
cum_error = zeros(size(list));
count = 1;

for j = list
  cum_error(count) = length(find(error < j)) / (i);
  count = count + 1;
end

plot(list, cum_error, 'r-^', 'MarkerSize', 2, 'linewidth', 1);
legend([opt.m.shape_model ' | ' opt.m.tex_model ' | ' opt.algorithm], 'Location', 'SouthEast')
drawnow
