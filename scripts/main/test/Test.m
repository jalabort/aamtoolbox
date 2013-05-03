%figure
hold on
set(gca, 'FontSize', 0.05)
set(gca, 'FontWeight', 'bold')
ytick = 0:0.1:1;
set(gca, 'ytick', ytick);
limit = 0.05;
xtick = 0:0.01:limit;
set(gca, 'xtick', xtick);
ylabel('Proportion of Images', 'Interpreter', 'tex', 'fontsize', 15)
xlabel('Shape RMSE', 'Interpreter', 'tex', 'fontsize', 15)
title('LFPW','Interpreter', 'tex', 'fontsize', 15)
grid on

error = zeros(test_ds.n_data,1);

for i = 1:test_ds.n_data
  temp1 = test_ds.data{i}.ann;
  temp2 = fann(:,:,i);
  face_size = mean(max(temp1) - min(temp1));
  error(i) = mean(sqrt(sum((temp1 - temp2).^2,2))) / face_size;
end

list = 0:0.0005:limit;
cum_error = zeros(size(list));
count = 1;

for i = list
  cum_error(count) = length(find(error < i)) / (test_ds.n_data);
  count = count + 1;
end

plot(list, cum_error, 'b-^', 'MarkerSize', 2, 'linewidth', 1);
legend([opt.m.shape_model ' | ' opt.m.tex_model ' | ' opt.algorithm], 'Location', 'SouthEast')

