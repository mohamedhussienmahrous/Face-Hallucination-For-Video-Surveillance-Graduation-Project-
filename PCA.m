function [EignVectors] = PCA(InputImages )
EignVectors = pca(InputImages);
 ViewMoreImageInTheSameFigure(EignVectors',100,'PCA OUTPUT Images',0);
end

