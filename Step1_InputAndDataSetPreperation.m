function [ DataSet,Num ] = Step1_InputAndDataSetPreperation(path,Width,Height,Factor)
DataSet=[];
Num=[];
close('all');
VidObject = VideoReader(path);
VidObject.currentTime=0.0;%56
while hasFrame(VidObject)
    frame = readFrame(VidObject);
    [T, BB]=FaceDetectionVJ(frame);
    if T > 0
        Index=1;
        while Index<=T
            %step 1
            [Numb , Out] =  Facetracking(VidObject,BB(Index,:),frame,Width,Height,Factor);
            DataSet=[DataSet;Out];
            Num=[Num;Numb];
            Index=Index + 1;
        end;
    end;
    
end;
end

