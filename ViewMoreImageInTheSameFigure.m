function ViewMoreImageInTheSameFigure( InputImages,NumberOfImages,FigureTitle,RowOrStruct )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
TMP=[];

if RowOrStruct ==1
[Width,Hieght]=size(InputImages(1).cdata);
    for i=1:NumberOfImages
        NIM=InputImages(i).cdata;
    NIM=reshape(NIM,1,Width*Hieght);
        TMP=[TMP;NIM];
    end
else 
    
    [X,Y]=size(InputImages);
    Hieght=sqrt(Y);
    Width=Hieght;
    TMP=InputImages;
end

figure,

for n=1:10
    o=TMP(n,:);
   % o=o';
 %   Face =OUTtranspose *o;
    M=reshape(o,[Width,Hieght]);
    subplot(2,ceil(5),n),imshow(M,[]),
end
title(FigureTitle);
end

