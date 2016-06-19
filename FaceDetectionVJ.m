function [NumberOfFaces,BB] = FaceDetectionVJ( Im )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%Detect objects using Viola-Jones Algorithm
%To detect Face
FDetect = vision.CascadeObjectDetector;
%Returns Bounding Box values based on number of objects
BB = step(FDetect,Im);
NumberOfFaces=size(BB,1);
%figure ,hold on,imshow(Im),
%for i = 1:size(BB,1)
 %   rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
%end
%hold off
end