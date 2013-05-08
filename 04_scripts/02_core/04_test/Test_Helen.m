%figure
hold on
set(gca, 'FontSize', 0.05)
%set(gca, 'FontWeight', 'bold')
ytick = 0:0.1:1;
set(gca, 'ytick', ytick);
limit = 0.2;
xtick = 0:0.02:limit;
set(gca, 'xtick', xtick);
ylabel('Proportion of Images', 'Interpreter', 'tex', 'fontsize', 15)
xlabel('m-194', 'Interpreter', 'tex', 'fontsize', 15)
title('Helen Facial Feature Dataset','Interpreter', 'tex', 'fontsize', 15)
grid on

error = zeros(test_ds.n_data,1);

for i = 1:test_ds.n_data
  temp1 = test_ds.data{i}.ann;
  temp2 = fann(:,:,i);
  eye1 = mean(temp1(test_ds.comp{3},:));
  eye2 = mean(temp1(test_ds.comp{4},:));
  eye_dist = mean(sqrt(sum((eye1 - eye2).^2,2)));
%   eye_dist = mean(sqrt(sum((temp1(125,:) - temp2(145,:)).^2,2)));
  error(i) = mean(sqrt(sum((temp1 - temp2).^2,2))) / eye_dist;
end

list = 0:0.005:limit;
cum_error = zeros(size(list));
count = 1;

for i = list
  cum_error(count) = length(find(error < i)) / (test_ds.n_data);
  count = count + 1;
end

plot(list, cum_error, 'g-o',  'MarkerSize', 5, 'linewidth', 1);

% list = 0:0.005:limit;
% cum_error = zeros(size(list));
% count = 1;
% 
% for i = list
%   cum_error(count) = length(find(error < i)) / (test_ds.n_data);
%   count = count + 1;
% end
% 
% plot(list, cum_error, 'magenta^', 'MarkerSize', 5);


legend('Parts-Based AAMs','Le et al. + AAMs', 'AAMs', 'Location', 'SouthEast')


