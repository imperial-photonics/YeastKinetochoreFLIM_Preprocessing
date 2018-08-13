function nth_feedback(handles, image, mask)
image_masked = double(image) .* double(mask);

% region number
L = bwlabel(mask);
reg_num = max(L(:));
% = 'reg_num';
set(handles.edit_reg_num,'String',num2str(reg_num));

% mean pixel value
mean_img = mean(nonzeros(image_masked(:)));
%field_mean = 'mean';
set(handles.edit_mean_pix_val,'String',num2str(mean_img));

% median pixel value
median_img = median(nonzeros(image_masked(:)));
%field_median = 'median';
set(handles.edit_med_pix_val,'String',num2str(median_img));

% max pixel value
max_img = mean(max(nonzeros(image_masked(:))));
%field_max = 'max';
set(handles.edit_max_pix_val,'String',num2str(max_img));

% min pixel value
min_img = mean(min(nonzeros(image_masked(:))));
%field_max = 'min';
set(handles.edit_min_pix_val,'String',num2str(min_img));

% standard deviation of pixel values
stddev_img = mean(std(nonzeros(image_masked(:))));
set(handles.edit_stddev,'String',num2str(stddev_img));

return
