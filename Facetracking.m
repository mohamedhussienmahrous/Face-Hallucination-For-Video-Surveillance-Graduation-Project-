function [Num, Image_cropped ] = Facetracking(videoFileReader,Facedetected,videoFrame,Width,Height,Factor)
Num=0;
% from refrance http://www.mathworks.com/matlabcentral/fileexchange/47105-detect-and-track-multiple-faces/content/detectAndTrackFaces.m
faceDetector = vision.CascadeObjectDetector();
% Read a video frame and run the face detector.
bbox = Facedetected;
% Draw the returned bounding box around the detected face.
videoFrame = insertShape(videoFrame, 'Rectangle', bbox);
figure; imshow(videoFrame); title('Detected face');

% Convert the first box into a list of 4 points
% This is needed to be able to visualize the rotation of the object.
bboxPoints = bbox2points(bbox(1, :));
points = detectMinEigenFeatures(rgb2gray(videoFrame), 'ROI', bbox);

% Display the detected points.
figure, imshow(videoFrame), hold on, title('Detected features');
plot(points);
% Create a point tracker and enable the bidirectional error constraint to
% make it more robust in the presence of noise and clutter.
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);

% Initialize the tracker with the initial point locations and the initial
% video frame.
points = points.Location;
initialize(pointTracker, points, videoFrame);
videoPlayer  = vision.VideoPlayer('Position',...
    [100 100 [size(videoFrame, 2), size(videoFrame, 1)]+30]);
oldPoints = points;

index=1;
Image_cropped =[];
while hasFrame(videoFileReader)
   % get the next frame
%for i=1:40
    videoFrame = readFrame(videoFileReader);
    % Track the points. Note that some points may be lost.
    [points, isFound] = step(pointTracker, videoFrame);
    visiblePoints = points(isFound, :);
    oldInliers = oldPoints(isFound, :);

    if size(visiblePoints, 1) >= 2 % need at least 2 points
        % Estimate the geometric transformation between the old points
        % and the new points and eliminate outliers
        [xform, oldInliers, visiblePoints] = estimateGeometricTransform(...
            oldInliers, visiblePoints, 'similarity', 'MaxDistance', 4);

        % Apply the transformation to the bounding box points
        bboxPoints = transformPointsForward(xform, bboxPoints);    
         minX = min(bboxPoints(:,1));
         minY= min(bboxPoints(:,2));  
          width = max(bboxPoints(:,1))- min(bboxPoints(:,1));         
         heigth = max(bboxPoints(:,2))- min(bboxPoints(:,2));        

        % Insert a bounding box around the object being tracked
        bboxPolygon = reshape(bboxPoints', 1, []); 
        I2 = imcrop(videoFrame,[minX minY width heigth]);
        I2=imresize(I2,[Width*Factor,Height*Factor],'bicubic');
        IMAGE=rgb2ycbcr(I2);
        X= double(IMAGE(:,:,1));
        X=reshape(X,1,Width*Factor*Height*Factor);
        Image_cropped=[Image_cropped;X];
        index=index+1;
        videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygon,'LineWidth', 2);
        % Display tracked points
        videoFrame = insertMarker(videoFrame, visiblePoints, '+', ...
            'Color', 'white');

        % Reset the points
        oldPoints = visiblePoints;
        setPoints(pointTracker, oldPoints);
    
    end
Num=index-1;
    % Display the annotated video frame using the video player object
    step(videoPlayer, videoFrame);
end

% Clean up
%release(videoFileReader);
%release(videoPlayer);
%release(pointTracker);
end

