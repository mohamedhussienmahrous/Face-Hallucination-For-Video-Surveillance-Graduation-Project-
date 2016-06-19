function [cell_k_patches] = mqSplitImg2Patches(k_images, patch_size, overlap)
global VISUALS;
    %% loop images
    for k = 1 : size(k_images)
        im = k_images{k};
        num_patches = ceil((size(im, 1) * size(im, 2)) / (patch_size * patch_size));
        if(overlap > 0)
            actual_width = size(im, 2) + (size(im, 2) / patch_size)-1;
            num_patches = ceil((size(im, 1) * actual_width) / (patch_size * patch_size));
        end
        patches = cell(num_patches, 1);
        patches_counter = 1;
        %% visualize
        if(VISUALS == true)
            obj_shape_insert = vision.ShapeInserter('BorderColor', 'Custom', 'CustomBorderColor', [46 139 87]);
            visual_im = im;
        end
        %% loop rows
        fin_col = size(im, 2) - patch_size + 1;
        step_col = patch_size - overlap
        for c = 1 : step_col : fin_col
            %% loop cols
            fin_row = size(im, 1) - patch_size + 1;
            for r = 1 : patch_size : fin_row
                patches{patches_counter} = im([r:r+patch_size-1], [c:c+patch_size-1]);
                %% visualize
                if(VISUALS == true)
                    visual_im = step(obj_shape_insert, visual_im, int32([r c patch_size patch_size]));
                end
                %% increment inner most loop counters
                patches_counter = patches_counter + 1;
            end %% end loop columns
        end %% end loop rows
        file_name = sprintf('patches/%d.mat', k);
        save(file_name,'patches');
        if(VISUALS == true)
            figure, imshow(visual_im), title(sprintf('%dth nearest image', k));
        end
    end %% end loop images
end
