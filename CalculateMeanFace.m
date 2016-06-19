function [ MeanFace ] = CalculateMeanFace( Images )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[Width,Hieght]=size(Images);
MeanFace=[];
for i=1:Hieght
    MeanFace=[MeanFace; mean(Images(:,i))];
end

Mean=reshape(MeanFace,180,180);
figure,title('Meannnnnn'),imshow(Mean,[]);

end

