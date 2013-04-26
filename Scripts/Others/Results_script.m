
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

mean(error)
median(error)
min(error)
max(error)