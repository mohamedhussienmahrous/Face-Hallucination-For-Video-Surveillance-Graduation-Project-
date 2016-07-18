function HallucinatedFaceImage = Step3_addinghighfrequency( GloballyEnhancesFaceImage,DataSet, Threshold,Patch_w,Patch_h,Width,Height,ANNK)
%UN
ImWidth=Width;
ImHeight=Height;
[row,col] = size(DataSet);
W=reshape(DataSet(1,:),[ImWidth,ImHeight]);
newpicture = [];
d = [];
lowOut=zeros(row,ImWidth,ImHeight);
highout=zeros(row,ImWidth,ImHeight);
Patch_heigth = Patch_h;
Patch_width = Patch_w;

for j = 1:row
    % figure,imshow(reshape(DataSet(j,:),180,180),[]);
    lowOut(j,:,:) = fun(reshape(DataSet(j,:),ImWidth,ImHeight),Threshold,0);
    % figure,imshow(reshape(lowOut(j,:),180,180),[]);
    highout(j,:,:) = fun(reshape(DataSet(j,:),ImWidth,ImHeight),Threshold,1);
    % figure,imshow(reshape(highout(j,:),180,180),[]);
   % close all;
end

for i = 1:row
    patches_of_low{i,:,:} = Patches(lowOut(i,:,:),Patch_heigth,Patch_width,ImWidth,ImHeight);
    patches_of_high{i,:,:} = Patches(highout(i,:,:),Patch_heigth,Patch_width,ImWidth,ImHeight);
end
globalEnhancedFacePatches = Patches(reshape(GloballyEnhancesFaceImage,[ImWidth,ImHeight]),Patch_heigth,Patch_width,ImWidth,ImHeight);

for i=1:((ImHeight)/Patch_heigth)
    for j=1:(ImWidth/Patch_width)
        dictionary = [];
        for p=1:row-1
            TEST=patches_of_low{p};
            d=reshape(TEST{i,j},[1,Patch_heigth*Patch_width]);
            dictionary = [dictionary;d];
        end
        
        qeuery = reshape(globalEnhancedFacePatches{i,j},[1,Patch_heigth*Patch_width]);
        K = ANN(qeuery,dictionary,ANNK);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        d=[];
        for f=1:length(K)
            G=patches_of_high{K(1,f),:,:};
            d = [d ;reshape(G{i,j},[1,Patch_heigth*Patch_width])];
        end
        calculated_med = (median(d));
        newpicture{i,j} = reshape(calculated_med,[Patch_heigth,Patch_width]);
    end
end
HallucinatedFaceImage = cell2mat(newpicture);
figure,imshow(HallucinatedFaceImage,[]);
end