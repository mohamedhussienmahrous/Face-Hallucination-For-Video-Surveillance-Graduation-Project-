function [ indexes_of_nearest_patches ] = ANN(Query,dataset,K)
%ANN Summary of this function goes here
%   Detailed explanation goes here

% [number_of_images_in_dataset, ~] = size(dataset);
% for i=1:number_of_images_in_dataset
%     [H ,w] = size(dataset(i,:));
%     d = [d; reshape(dataset(i,:),[1,H*w])];
% end

MLd = createns(dataset,'NSMethod','kdtree','Distance','minkowski');

indexes_of_nearest_patches=knnsearch(MLd,Query,'K',K);

end

