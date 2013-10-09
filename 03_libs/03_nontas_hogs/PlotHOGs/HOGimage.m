function im = HOGimage(w)
% make pictures of positive and negative weights
bs = 20;
w = w(:,:,1:9);
scale = max(max(w(:)),max(-w(:)));
pos = HOGpicturePos(w, bs) * 255/scale;
neg = HOGpicturePos(-w, bs) * 255/scale;

% put pictures together and draw
buff = 10;
pos = padarray(pos, [buff buff], 128, 'both');
if min(w(:)) < 0
  neg = padarray(neg, [buff buff], 128, 'both');
  im = uint8([pos; neg]);
else
  im = uint8(pos);
end

end