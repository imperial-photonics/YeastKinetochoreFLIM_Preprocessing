function z = nth_segmentation(U,scale,rel_bg_scale,threshold,smoothing,min_area,fixed_size_flag) 
%Object segmentation based on local thresholding
%scale=100,rel_bg_scale=2,threshold=0.1,smoothing=5,min_area=200
%scale,Object width (pixels)
%rel_bg_scale,Background size used to calculate threshold/Object width (>1)
%threshold,Threshold (0 or greater)
%smoothing,Radius of smoothing kernel (pixels)
%min_area,Minimium object area (pixels^2)



%
% Copyright (C) 2013 Imperial College London.
% All rights reserved.
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along
% with this program; if not, write to the Free Software Foundation, Inc.,
% 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
%
% This software tool was developed with support from the UK 
% Engineering and Physical Sciences Council 
% through  a studentship from the Institute of Chemical Biology 
% and The Wellcome Trust through a grant entitled 
% "The Open Microscopy Environment: Image Informatics for Biological Sciences" (Ref: 095931).

S = scale;
K = rel_bg_scale;
t = threshold;
se = strel('disk',max(1,round(abs(smoothing))));

if K<1
    K=1;
end

% nonlinear tophat + otsu thersholded
nth = nonlinear_tophat(U,S,K)-1;

norm = max(nth(:));
norm = min(norm,10000);
nth = nth / norm;
t = t / norm;

t = max(t,0);
t = min(t,1);

b1 = im2bw(nth,t);
b2 = imerode(b1,se); 
b1 = imdilate(b2,se);

%clf

L = bwlabel(b1);
stats = regionprops(L,'Area','Eccentricity');
%idx = find([stats.Area] >= min_area & [stats.Eccentricity] < 1);
%z = ismember(L,idx);

idx = find([stats.Eccentricity] < 1);

% For making the regions of a fixed size
if fixed_size_flag
    %errordlg('Test','Error'); % For testing
    [row_U, col_U] = size(U);
    z = logical(zeros(row_U, col_U));
    
    max_individual = zeros(length(idx),1);
    max_row = zeros(length(idx),1);
    max_col = zeros(length(idx),1);
    mean_U = trimmean(U(:),20);
    count = 1;
    
    % find the maximum pixel value for each region
    for region_id = 1:length(idx)
        region_individual = ismember(L,region_id);
        U_individual = U .* region_individual;
        max_individual_temp = max(U_individual(:));
        if max_individual_temp <= mean_U
            continue;
        end
        max_individual(count) = max_individual_temp;
        [max_row_temp, max_col_temp] = find(U_individual == max_individual(count));
        max_row(count) = max_row_temp(1);
        max_col(count) = max_col_temp(1);
        count = count + 1;
    end
    if count > 1
        max_individual = max_individual(1:(count-1));
        max_row = max_row(1:(count-1));
        max_col = max_col(1:(count-1));
        idx = 1 : (count-1);
    else
        return;
    end
    
    % exclude the dimmest 5% pixels and the brightest 5% pixels
    max_sorted = sort(max_individual);
    low_thres_idx = ceil((count-1)/20);
    high_thres_idx = (count-1) - floor((count-1)/20);
    low_thres_value = max_sorted(low_thres_idx);
    high_thres_value = max_sorted(high_thres_idx);
    dim_pixel_idx = find(max_individual < low_thres_value);
    bright_pixel_idx = find(max_individual > high_thres_value);
    new_idx = idx .* (~ismember(idx,dim_pixel_idx)) .* (~ismember(idx,bright_pixel_idx));
    new_idx = nonzeros(new_idx);
    
    % use refining factor to exclude outliers that are too far away from
    % the mean
    %mean_max = mean(max_individual);
    %stddev_max = std(max_individual);
    %low_thres_value = mean_max - refining_factor * stddev_max; % instead of - refining_factor * stddev_max
    %high_thres_value = mean_max + refining_factor * stddev_max;
    %dim_pixel_idx = find(max_individual <= low_thres_value);
    %bright_pixel_idx = find(max_individual >= high_thres_value);
    %new_idx = idx .* (~ismember(idx,dim_pixel_idx)) .* (~ismember(idx,bright_pixel_idx));
    %new_idx = nonzeros(new_idx);
    
    %mean_max = mean(max_individual(new_idx));
    %stddev_max = std(max_individual(new_idx));
    %low_thres_value = mean_max;
    %high_thres_value = mean_max + refining_factor * stddev_max;
    %dim_pixel_idx = find(max_individual <= low_thres_value);
    %bright_pixel_idx = find(max_individual >= high_thres_value);
    %new_idx = idx .* (~ismember(idx,dim_pixel_idx)) .* (~ismember(idx,bright_pixel_idx));
    %new_idx = nonzeros(new_idx);
    
    % selecting pixels and marking them as 1 based on the requirement specified by "min_area"   
    for new_region_id = 1:length(new_idx)
        i = new_idx(new_region_id);
        if max_row(i) < 30 || max_col(i) < 30 || max_row(i) > 226 || max_col(i) > 306
            continue;
        end
        if min_area == 0
            z(max_row(i)-3, max_col(i)-3) = 1;
            z(max_row(i)-3, max_col(i)-2) = 1;
            z(max_row(i)-3, max_col(i)-1) = 1;
            z(max_row(i)-3, max_col(i)) = 1;
            z(max_row(i)-3, max_col(i)+1) = 1;
            z(max_row(i)-3, max_col(i)+2) = 1;
            z(max_row(i)-3, max_col(i)+3) = 1;
            z(max_row(i)-2, max_col(i)-3) = 1;            
            %z(max_row(i)-2, max_col(i)-2) = 1;
            %z(max_row(i)-2, max_col(i)-1) = 1;
            %z(max_row(i)-2, max_col(i)) = 1;
            %z(max_row(i)-2, max_col(i)+1) = 1;
            %z(max_row(i)-2, max_col(i)+2) = 1;
            z(max_row(i)-2, max_col(i)+3) = 1;
            z(max_row(i)-1, max_col(i)-3) = 1;            
            %z(max_row(i)-1, max_col(i)-2) = 1;
            %z(max_row(i)-1, max_col(i)+2) = 1;
            z(max_row(i)-1, max_col(i)+3) = 1;
            z(max_row(i), max_col(i)-3) = 1;            
            %z(max_row(i), max_col(i)-2) = 1;
            %z(max_row(i), max_col(i)+2) = 1;
            z(max_row(i), max_col(i)+3) = 1;
            z(max_row(i)+1, max_col(i)-3) = 1;            
            %z(max_row(i)+1, max_col(i)-2) = 1;
            %z(max_row(i)+1, max_col(i)+2) = 1;
            z(max_row(i)+1, max_col(i)+3) = 1;
            z(max_row(i)+2, max_col(i)-3) = 1;            
            %z(max_row(i)+2, max_col(i)-2) = 1;
            %z(max_row(i)+2, max_col(i)-1) = 1;
            %z(max_row(i)+2, max_col(i)) = 1;
            %z(max_row(i)+2, max_col(i)+1) = 1;
            %z(max_row(i)+2, max_col(i)+2) = 1;
            z(max_row(i)+2, max_col(i)+3) = 1;
            z(max_row(i)+3, max_col(i)-3) = 1;
            z(max_row(i)+3, max_col(i)-2) = 1;
            z(max_row(i)+3, max_col(i)-1) = 1;
            z(max_row(i)+3, max_col(i)) = 1;
            z(max_row(i)+3, max_col(i)+1) = 1;
            z(max_row(i)+3, max_col(i)+2) = 1;
            z(max_row(i)+3, max_col(i)+3) = 1;
            continue;
        end
        if min_area == 1
            z(max_row(i), max_col(i)) = 1;
            continue;
        end
        if min_area == 2
            area_1 = [U(max_row(i)-1,max_col(i)-1),U(max_row(i)-1,max_col(i));U(max_row(i),max_col(i)-1),U(max_row(i),max_col(i))];
            area_2 = [U(max_row(i)-1,max_col(i)),U(max_row(i)-1,max_col(i)+1);U(max_row(i),max_col(i)),U(max_row(i),max_col(i)+1)];
            area_3 = [U(max_row(i),max_col(i)-1),U(max_row(i),max_col(i));U(max_row(i)+1,max_col(i)-1),U(max_row(i)+1,max_col(i))];
            area_4 = [U(max_row(i),max_col(i)),U(max_row(i),max_col(i)+1);U(max_row(i)+1,max_col(i)),U(max_row(i)+1,max_col(i)+1)];
            mean_area = [mean(area_1(:)), mean(area_2(:)), mean(area_3(:)), mean(area_4(:))];
            id_max = find(mean_area == max(mean_area(:)));
            switch id_max(1)
                case 1
                    z(max_row(i)-1,max_col(i)-1) = 1;
                    z(max_row(i)-1,max_col(i)) = 1;
                    z(max_row(i),max_col(i)-1) = 1;
                    z(max_row(i),max_col(i)) = 1;
                case 2
                    z(max_row(i)-1,max_col(i)) = 1;
                    z(max_row(i)-1,max_col(i)+1) = 1;
                    z(max_row(i),max_col(i)) = 1;
                    z(max_row(i),max_col(i)+1) = 1;
                case 3
                    z(max_row(i),max_col(i)-1) = 1;
                    z(max_row(i),max_col(i)) = 1;
                    z(max_row(i)+1,max_col(i)-1) = 1;
                    z(max_row(i)+1,max_col(i)) = 1;
                case 4
                    z(max_row(i),max_col(i)) = 1;
                    z(max_row(i),max_col(i)+1) = 1;
                    z(max_row(i)+1,max_col(i)) = 1;
                    z(max_row(i)+1,max_col(i)+1) = 1;
                otherwise
                    errordlg('Error in finding a brightest 2x2 region','Error');
            end
        end
    end
else
    idx = find([stats.Area] >= min_area);
    z = ismember(L,idx);
end

z = bwlabel(z);

return;
