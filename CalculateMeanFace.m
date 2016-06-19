function [ MeanFace ] = CalculateMeanFace( Images,Width,Height )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[W,Hieght]=size(Images);
MeanFace=[];
for i=1:Hieght
    MeanFace=[MeanFace; mean(Images(:,i))];
end

Mean=reshape(MeanFace,Width,Height);
figure,title('Meannnnnn'),imshow(Mean,[]);

end

