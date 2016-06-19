function [GlobalFace] = Step2_GlobalFaceShapeReconstruction(DataSet,Width,Height,Factor,PCAK,Lamda)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
MeanFace=CalculateMeanFace(DataSet,Width*Factor,Height*Factor);
TargetFaceROW=DataSet(1,:);
TargetFaceImage=reshape(TargetFaceROW,[Width*Factor,Height*Factor]);
[EignVectors]=  PCA(DataSet);
       B=EignVectors;
       Y=TargetFaceROW';
              %Difference Face
            Diff=Y- MeanFace;
            DiffFace=reshape(Diff,[Width*Factor,Height*Factor]);
            figure,imshow(DiffFace,[]),title('Difference Face');
            [AlphaVector]=l1ls_featuresign(B(:,1:PCAK),Y,Lamda);
             GloallyEnhancedFaceImage=TargetFaceImage+reshape(B(:,1:PCAK)*AlphaVector, [Width*Factor,Height*Factor]);
            figure,imshow(GloallyEnhancedFaceImage,[]),title('GloballyEnhancedFaceImage');
            %bilateral Filtering
            normImage = mat2gray(GloallyEnhancedFaceImage);
            Out= bfilter2(normImage,3,[5,0.1]);
            figure,imshow(Out,[]),title('Bilateral Filtering');
            %% st2kd menha
            GlobalFace = Out;
end