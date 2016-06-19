function HallucinatedFaceImage = Step3_addinghighfrequency( GloballyEnhancesFaceImage,DataSet, Threshold)
%UN
close all;
[row,col] = size(DataSet);
W=reshape(DataSet(1,:),[180,180]);
newpicture = [];
d = [];
lowOut=zeros(row,180,180);
highout=zeros(row,180,180);
Patch_heigth = 20;
Patch_width = 20;

for j = 1:row
    % figure,imshow(reshape(DataSet(j,:),180,180),[]);
    lowOut(j,:,:) = fun(reshape(DataSet(j,:),180,180),Threshold,0);
    % figure,imshow(reshape(lowOut(j,:),180,180),[]);
    highout(j,:,:) = fun(reshape(DataSet(j,:),180,180),Threshold,1);
    % figure,imshow(reshape(highout(j,:),180,180),[]);
    close all;
end

for i = 1:row
    patches_of_low{i,:,:} = Patches(lowOut(i,:,:),Patch_heigth,Patch_width);
    patches_of_high{i,:,:} = Patches(highout(i,:,:),Patch_heigth,Patch_width);
end
globalEnhancedFacePatches = Patches(reshape(GloballyEnhancesFaceImage,[180,180]),Patch_heigth,Patch_width);

for i=1:((180)/Patch_heigth)
    
    for j=1:(180/Patch_width)
        dictionary = [];
        for p=1:row-1
            TEST=patches_of_low{p};
            d=reshape(TEST{i,j},[1,Patch_heigth*Patch_width]);
            dictionary = [dictionary;d];
        end
        
        qeuery = reshape(globalEnhancedFacePatches{i,j},[1,Patch_heigth*Patch_width]);
        K = ANN(qeuery,dictionary,7);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        d=[];
        for f=1:length(K)
            G=patches_of_high{K(1,f),:,:};
            d = [d ;reshape(G{i,j},[1,Patch_heigth*Patch_width])];
        end
        calculated_med = int64(median(d));
        newpicture{i,j} = reshape(calculated_med,[Patch_heigth,Patch_width]);
    end
end
HallucinatedFaceImage = cell2mat(newpicture);
figure,imshow(HallucinatedFaceImage,[]);
end