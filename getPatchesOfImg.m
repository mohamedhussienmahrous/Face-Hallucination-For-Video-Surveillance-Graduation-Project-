function [ patches ] = getPatchesOfImg(img, flag)
%GETPATCHES Summary of this function goes here
%   I supposed that img is row vector of image
%   patches is array of patches each row contains one patch
%   flag is boolean parameter if true then i will construct overlaping
%   patchs if false then construct n-overlaping patches

%%  ======================== useful variables ========================= %%
img = reshape(img,[180,180]);
%figure,
%imshow(img,[]);
[m n] = size(img);
patch_size = 45;%<--
%% ================== i Will return this vars ========================= %%
patches = [];

%% ================== implementation ================================== %%

%patches = reshape(img,patches_rows,patches_cols);

patchR_index_start = 1;
patchR_index_end = 45;%<--

patchC_index_start = 1;
patchC_index_end = 45;%<--
tmp = img;
count = 0;
%figure,
%img=32400 px
%#patches = 661
while patchR_index_end <= m
    
    while patchC_index_end <= n
        %count = count+1;
        tmp(patchR_index_start:patchR_index_end , patchC_index_start : patchC_index_end) = 0;
        %imshow(tmp,[]);
        patch = img(patchR_index_start:patchR_index_end , patchC_index_start : patchC_index_end);
        %subplot(4,7,count),imshow(patch,[]);
        patches = [patches reshape(patch,1,patch_size^2)];
        if flag == 1
        patchC_index_start = patchC_index_end;
        patchC_index_end = patchC_index_end + 4;
        else
            patchC_index_start = patchC_index_end + 1;
            patchC_index_end = patchC_index_end + 45;%<--
        end
        tmp = img;
    end
    patchR_index_start = patchR_index_end + 1;
    patchR_index_end = patchR_index_end + 45;%<--
    
    patchC_index_start = 1;
    patchC_index_end =  45;%<--
end
%plotPatches(patches(1,:),'Patches');
end