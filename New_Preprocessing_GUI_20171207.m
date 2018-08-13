function varargout = New_Preprocessing_GUI_20171207(varargin)
% NEW_PREPROCESSING_GUI_20171207 MATLAB code for New_Preprocessing_GUI_20171207.fig
%      NEW_PREPROCESSING_GUI_20171207, by itself, creates a new NEW_PREPROCESSING_GUI_20171207 or raises the existing
%      singleton*.
%
%      H = NEW_PREPROCESSING_GUI_20171207 returns the handle to a new NEW_PREPROCESSING_GUI_20171207 or the handle to
%      the existing singleton*.
%
%      NEW_PREPROCESSING_GUI_20171207('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEW_PREPROCESSING_GUI_20171207.M with the given input arguments.
%
%      NEW_PREPROCESSING_GUI_20171207('Property','Value',...) creates a new NEW_PREPROCESSING_GUI_20171207 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before New_Preprocessing_GUI_20171207_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to New_Preprocessing_GUI_20171207_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help New_Preprocessing_GUI_20171207

% Last Modified by GUIDE v2.5 07-Feb-2018 01:33:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @New_Preprocessing_GUI_20171207_OpeningFcn, ...
                   'gui_OutputFcn',  @New_Preprocessing_GUI_20171207_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before New_Preprocessing_GUI_20171207 is made visible.
function New_Preprocessing_GUI_20171207_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to New_Preprocessing_GUI_20171207 (see VARARGIN)

% Choose default command line output for New_Preprocessing_GUI_20171207
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.edit_std_scaling_factor,'String','3');
set(handles.edit_minimum_deadcell_area,'String','64');
set(handles.edit_nth_scale,'String','2');
set(handles.edit_nth_rel_bg_scale,'String','5');
set(handles.edit_nth_threshold,'String','1');
set(handles.edit_nth_smoothing,'String','1');
set(handles.edit_nth_min_pixel_num,'String','1');
set(handles.edit_lower_refining_factor,'String','1');
set(handles.edit_upper_refining_factor,'String','1');
set(handles.edit_prebleach_num,'String','5');

% Initialise global variables
global raw_FLIM_folder raw_DC raw_DC_folder integrated_noDC_FLIM_folder...
    dead_cell_masks_folder nth_masks_folder kinetochore_only_masks_folder...
    tvb_subtracted_images_folder flag_dead_cell mean_integrated_noDC_FLIM...
    stddev_integrated_noDC_FLIM; 
raw_FLIM_folder = '0';
raw_DC = '0';
raw_DC_folder = '0';
integrated_noDC_FLIM_folder = '0';
dead_cell_masks_folder = '0';
nth_masks_folder = '0';
kinetochore_only_masks_folder = '0';
tvb_subtracted_images_folder = '0';
flag_dead_cell = 0;
mean_integrated_noDC_FLIM = 0;
stddev_integrated_noDC_FLIM = 0;

% UIWAIT makes New_Preprocessing_GUI_20171207 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = New_Preprocessing_GUI_20171207_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_raw_FLIM_folder_Callback(hObject, eventdata, handles)
% hObject    handle to edit_raw_FLIM_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_raw_FLIM_folder as text
%        str2double(get(hObject,'String')) returns contents of edit_raw_FLIM_folder as a double


% --- Executes during object creation, after setting all properties.
function edit_raw_FLIM_folder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_raw_FLIM_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_raw_FLIM_folder_selection.
function pushbutton_raw_FLIM_folder_selection_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_raw_FLIM_folder_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global raw_FLIM_folder;
raw_FLIM_folder = FLIMgetdir(1);
set(handles.edit_raw_FLIM_folder,'String',raw_FLIM_folder);



% --- Executes on button press in pushbutton_DC_image_selection.
function pushbutton_DC_image_selection_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_DC_image_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global raw_DC raw_DC_folder;
[raw_DC,raw_DC_folder] = uigetfile({'*.tiff;*.tif','Tiff files (*.tiff;*.tif)';'*.*','All Files (*.*)'},...
    'Please select the DC background image with the appropriate frame number:');
if ~exist(raw_DC_folder, 'dir')
    return;
end
set(handles.edit_DC_image,'String',strcat(raw_DC_folder,raw_DC));



function edit_DC_image_Callback(hObject, eventdata, handles)
% hObject    handle to edit_DC_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_DC_image as text
%        str2double(get(hObject,'String')) returns contents of edit_DC_image as a double


% --- Executes during object creation, after setting all properties.
function edit_DC_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_DC_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in pushbutton_auto_folder_creation.
function pushbutton_auto_folder_creation_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_auto_folder_creation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global raw_FLIM_folder integrated_noDC_FLIM_folder dead_cell_masks_folder...
    nth_masks_folder kinetochore_only_masks_folder tvb_subtracted_images_folder...
    flag_dead_cell;
if ~exist(raw_FLIM_folder, 'dir')
    errordlg('Please select the folder contain raw FLIM images','Error');
    return;
end

% if raw_FLIM_folder exist, set the paths for the edits below; if the
% folders don't exist, create new folders

% Folder for integrated DC-subtracted images
integrated_noDC_FLIM_folder = strcat(raw_FLIM_folder,'/Integrated DC subtracted');
if ~exist(integrated_noDC_FLIM_folder, 'dir')
    mkdir(integrated_noDC_FLIM_folder);
end
set(handles.edit_integrated_noDC_folder,'String',integrated_noDC_FLIM_folder);
cd(integrated_noDC_FLIM_folder);
files_integrated_noDC = dir('*.tiff');
if length(files_integrated_noDC) ~= 0
    set(handles.listbox1,'string',{files_integrated_noDC.name});
    listbox1_Callback(handles.listbox1, [], handles);
end
flag_dead_cell = 0;
% Folder for dead cell masks
dead_cell_masks_folder = strcat(raw_FLIM_folder,'/Dead cell masks');
if ~exist(dead_cell_masks_folder, 'dir')
    mkdir(dead_cell_masks_folder);
end
set(handles.edit_dead_cell_masks_folder,'String',dead_cell_masks_folder);
% Folder for NTH masks
nth_masks_folder = strcat(raw_FLIM_folder,'/NTH masks');
if ~exist(nth_masks_folder, 'dir')
    mkdir(nth_masks_folder);
end
set(handles.edit_nth_masks_folder,'String',nth_masks_folder);
% Folder for kinetochore masks
kinetochore_only_masks_folder = strcat(raw_FLIM_folder,'/Kinetochore masks');
if ~exist(kinetochore_only_masks_folder, 'dir')
    mkdir(kinetochore_only_masks_folder);
end
set(handles.edit_kinetochore_only_masks_folder,'String',kinetochore_only_masks_folder);
% Folder for TVB-subtracted images
tvb_subtracted_images_folder = strcat(raw_FLIM_folder,'/TVB subtracted images');
if ~exist(tvb_subtracted_images_folder, 'dir')
    mkdir(tvb_subtracted_images_folder);
end
set(handles.edit_tvb_subtracted_images_folder,'String',tvb_subtracted_images_folder);



% --- Executes on button press in pushbutton_integrated_noDC_folder_selection.
function pushbutton_integrated_noDC_folder_selection_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_integrated_noDC_folder_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global integrated_noDC_FLIM_folder flag_dead_cell;
integrated_noDC_FLIM_folder = FLIMgetdir(5);
set(handles.edit_integrated_noDC_folder,'String',integrated_noDC_FLIM_folder);
flag_dead_cell = 0;
cd(integrated_noDC_FLIM_folder);
files_integrated_noDC = dir('*.tiff');
set(handles.listbox1,'string',{files_integrated_noDC.name});
try
    image = imread(fullfile(integrated_noDC_FLIM_folder,files_integrated_noDC(1).name));
catch
    return;
end
imshow(image, 'DisplayRange', [min(image(:)) max(image(:))/2], 'Parent', handles.axes1);
set(handles.listbox1,'string',{files_integrated_noDC.name});



% --- Executes on button press in pushbutton_dead_cell_masks_folder_selection.
function pushbutton_dead_cell_masks_folder_selection_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dead_cell_masks_folder_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dead_cell_masks_folder integrated_noDC_FLIM_folder;
dead_cell_masks_folder = FLIMgetdir(6);
set(handles.edit_dead_cell_masks_folder,'String',dead_cell_masks_folder);
cd(dead_cell_masks_folder);
existing_masks = dir('*.tiff');
if ~isempty(existing_masks)
    cd(integrated_noDC_FLIM_folder);
    existing_images = dir('*.tiff');
    if ~isempty(existing_images)
        listbox1_Callback(handles.listbox1, [], handles);
    else
        errordlg('There is no integrated FLIM image in the selected folder!','Error');
    end
end



% --- Executes on button press in pushbutton_nth_masks_folder_selection.
function pushbutton_nth_masks_folder_selection_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_nth_masks_folder_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global nth_masks_folder integrated_noDC_FLIM_folder;
nth_masks_folder = FLIMgetdir(7);
set(handles.edit_nth_masks_folder,'String',nth_masks_folder);
cd(nth_masks_folder);
existing_masks = dir('*.tiff');
if ~isempty(existing_masks)
    cd(integrated_noDC_FLIM_folder);
    existing_images = dir('*.tiff');
    if ~isempty(existing_images)
        listbox1_Callback(handles.listbox1, [], handles);
    else
        errordlg('There is no integrated FLIM image in the selected folder!','Error');
    end
end



% --- Executes on button press in pushbutton_kinetochore_only_masks_selection.
function pushbutton_kinetochore_only_masks_selection_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_kinetochore_only_masks_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global kinetochore_only_masks_folder;
kinetochore_only_masks_folder = FLIMgetdir(8);
set(handles.edit_kinetochore_only_masks_folder,'String',kinetochore_only_masks_folder);



% --- Executes on button press in pushbutton_tvb_subtracted_folder_selection.
function pushbutton_tvb_subtracted_folder_selection_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_tvb_subtracted_folder_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tvb_subtracted_images_folder;
tvb_subtracted_images_folder = FLIMgetdir(3);
set(handles.edit_tvb_subtracted_images_folder,'String',tvb_subtracted_images_folder);



% --- Executes on button press in pushbutton_dc_subtraction_and_integration.
function pushbutton_dc_subtraction_and_integration_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dc_subtraction_and_integration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global raw_FLIM_folder;
if ~exist(raw_FLIM_folder, 'dir')
    errordlg('Please select a directory for the folder with the raw FLIM images!','Error');
    return;
end
cd(raw_FLIM_folder);
raw_FLIM_list = dir('*.tiff');
num_FLIM_files = length(raw_FLIM_list);

global integrated_noDC_FLIM_folder;
if ~exist(integrated_noDC_FLIM_folder, 'dir')
    errordlg('Please select a folder for storing the DC-subtracted FLIM images!','Error');
    return;
end

global raw_DC raw_DC_folder;

mean_DC = FLIMgetDC(raw_DC,raw_DC_folder);

cd(raw_FLIM_folder);
raw_FLIM_reader = bfGetReader(raw_FLIM_list(1).name);
num_FLIM_planes = raw_FLIM_reader.getImageCount();
rows_FLIM = raw_FLIM_reader.getSizeY();   
cols_FLIM = raw_FLIM_reader.getSizeX();
raw_FLIM_reader.close();
integrated_noDC_FLIM = uint32(zeros(rows_FLIM,cols_FLIM,num_FLIM_files)); 

% Subtract the DC background off each plane of each raw FLIM image, and
% integrate each FLIM image
for loop_FLIM_list = 1:num_FLIM_files
    cd(raw_FLIM_folder);
    raw_FLIM_reader = bfGetReader(raw_FLIM_list(loop_FLIM_list).name);
    
    % Process each plane of the raw FLIM image
    for loop_FLIM_plane = 1:num_FLIM_planes
        DC_subtracted_FLIM_temp = bfGetPlane(raw_FLIM_reader,loop_FLIM_plane) - mean_DC;
        integrated_noDC_FLIM(:,:,loop_FLIM_list) = integrated_noDC_FLIM(:,:,loop_FLIM_list) + DC_subtracted_FLIM_temp;
    end
    
    % Save resulting image
    cd(integrated_noDC_FLIM_folder);
    save_as_OMEtiff(raw_FLIM_list(loop_FLIM_list).name,integrated_noDC_FLIM(:,:,loop_FLIM_list),[0]);
    raw_FLIM_reader.close();
end

cd(integrated_noDC_FLIM_folder);
files_integrated_noDC = dir('*.tiff');
set(handles.listbox1,'string',{files_integrated_noDC.name});
listbox1_Callback(handles.listbox1, [], handles);

msgbox('Operation Completed','Success');



% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
global integrated_noDC_FLIM_folder dead_cell_masks_folder nth_masks_folder image_global kinetochore_only_masks_folder;
if  ~exist(integrated_noDC_FLIM_folder,'dir')
    errordlg('The folder for storing integrated DC_subtracted FLIM images is not valid!','Error');
    return;
end

index_selected = get(handles.listbox1,'Value');
file_list = get(handles.listbox1,'String');
filename = file_list{index_selected};
image_global = imread(fullfile(integrated_noDC_FLIM_folder, filename));
imshow(image_global,'DisplayRange',[min(image_global(:)) max(image_global(:))/2], 'Parent', handles.axes1);

if exist(kinetochore_only_masks_folder,'dir')
    try
        mask_kinetochore_only = imread(fullfile(kinetochore_only_masks_folder,filename));
        
        min_pixel_num = str2double(get(handles.edit_nth_min_pixel_num,'String'));
        if min_pixel_num == 0
            se5 = strel('square',5);
            se3 = strel('square',3);
            mask_kinetochore_only = imdilate(mask_kinetochore_only,se5) - imdilate(mask_kinetochore_only,se3);
        end
        
        nth_feedback(handles, image_global, mask_kinetochore_only);
        
        se = strel('disk',3);
        mask_kinetochore_only = imdilate(mask_kinetochore_only,se);
        
        mask_red = cat(3, ones(size(mask_kinetochore_only)).*double(mask_kinetochore_only), zeros(size(mask_kinetochore_only)), zeros(size(mask_kinetochore_only)))*0.5;
        image_rgb = cat(3, ones(size(image_global)).*double(image_global), ones(size(image_global)).*double(image_global), ones(size(image_global)).*double(image_global))./double(max(image_global(:)));
        image_kinetochore_only_mask = image_rgb*2 + mask_red;
        imshow(image_kinetochore_only_mask,'Parent', handles.axes1);
        return;
    catch
    end
end

if exist(dead_cell_masks_folder,'dir')
    try
        mask_dead_cell = imread(fullfile(dead_cell_masks_folder,filename));
        mask_green = cat(3, zeros(size(mask_dead_cell)), ones(size(mask_dead_cell)).*double(mask_dead_cell), zeros(size(mask_dead_cell)))*0.5;
        image_rgb = cat(3, ones(size(image_global)).*double(image_global), ones(size(image_global)).*double(image_global), ones(size(image_global)).*double(image_global))./double(max(image_global(:)));
    catch
        if exist(nth_masks_folder,'dir')
            try
                mask_nth = imread(fullfile(nth_masks_folder, filename));
                nth_feedback(handles, image_global, mask_nth);
                
                se = strel('disk',3);
                mask_nth = imdilate(mask_nth,se);
                
                mask_blue = cat(3, zeros(size(mask_nth)),zeros(size(mask_nth)),ones(size(mask_nth)).*double(mask_nth))*0.5;
                image_rgb = cat(3, ones(size(image_global)).*double(image_global), ones(size(image_global)).*double(image_global), ones(size(image_global)).*double(image_global))./double(max(image_global(:)));
                image_mask = image_rgb*2 + mask_blue;
                imshow(image_mask,'Parent', handles.axes1);
                return;
            catch
                return;
            end            
        end
    end
    if exist(nth_masks_folder,'dir')
        try
            mask_nth = imread(fullfile(nth_masks_folder, filename));
            combined_mask = mask_nth & ~mask_dead_cell;
            nth_feedback(handles, image_global, combined_mask);
            
            se = strel('disk',3);
            mask_nth = imdilate(mask_nth,se);
            mask_blue= cat(3, zeros(size(mask_nth)),zeros(size(mask_nth)),ones(size(mask_nth)).*double(mask_nth))*0.5;
            image_mask = image_rgb*2 + mask_green + mask_blue;
            imshow(image_mask,'Parent', handles.axes1);
        catch
            image_mask = image_rgb*2 + mask_green;
            imshow(image_mask,'Parent', handles.axes1);
            return;
        end
    else
        image_mask = image_rgb*2 + mask_green;
        imshow(image_mask,'Parent', handles.axes1);
    end
end

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in pushbutton_dead_cell_mask_preview.
function pushbutton_dead_cell_mask_preview_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dead_cell_mask_preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global integrated_noDC_FLIM_folder image_global flag_dead_cell...
    mean_integrated_noDC_FLIM stddev_integrated_noDC_FLIM;

if ~exist(integrated_noDC_FLIM_folder,'dir')
   errordlg('The folder for storing integrated DC_subtracted FLIM images is not valid!','Error');
   return;
end

index_selected = get(handles.listbox1,'Value');
file_list = get(handles.listbox1,'String');
filename = file_list{index_selected};
image_global = imread(fullfile(integrated_noDC_FLIM_folder, filename));

if flag_dead_cell == 0
    cd(integrated_noDC_FLIM_folder);
    integrated_noDC_FLIM_list = dir('*.tiff');
    num_integrated_noDC_FLIM_files = length(integrated_noDC_FLIM_list);

    integrated_noDC_FLIM_reader = bfGetReader(integrated_noDC_FLIM_list(1).name);
    rows_FLIM = integrated_noDC_FLIM_reader.getSizeY();
    cols_FLIM = integrated_noDC_FLIM_reader.getSizeX();
    integrated_noDC_FLIM_reader.close();

    integrated_noDC_FLIM = uint32(zeros(rows_FLIM,cols_FLIM,num_integrated_noDC_FLIM_files)); 


    % Make integrated FLIM images
    for loop_FLIM_list = 1:num_integrated_noDC_FLIM_files
        % Get reader for each image, then store all images in the same matrix
        integrated_noDC_FLIM_reader = bfGetReader(integrated_noDC_FLIM_list(loop_FLIM_list).name);
  
        integrated_noDC_FLIM(:,:,loop_FLIM_list) = bfGetPlane(integrated_noDC_FLIM_reader,1);
      
        integrated_noDC_FLIM_reader.close();
    end

    % Consider all integrated images as a group and get the statistics of the
    % group
    integrated_noDC_FLIM_1D = reshape(integrated_noDC_FLIM,...
        [num_integrated_noDC_FLIM_files*rows_FLIM*cols_FLIM,1]);  % Create a 1d array to make getting the statistics easier

    mean_integrated_noDC_FLIM = mean(integrated_noDC_FLIM_1D);
    stddev_integrated_noDC_FLIM = std(single(integrated_noDC_FLIM_1D));
    
    flag_dead_cell = 1;
end

% Make binary masks based on some threshold (mean + x*std)
std_scaling_factor = str2double(get(handles.edit_std_scaling_factor,'String'));  % scaling factor for stddev
if isempty(std_scaling_factor)
    errordlg('Please enter a value for scaling the global stddev for thresholding!','Error');
    return;
end
min_deadcell_area = str2double(get(handles.edit_minimum_deadcell_area,'String'));
if isempty(std_scaling_factor)
    errordlg('Please enter a value for the minimum acceptable pixel area for dead cells!','Error');
    return;
end

dead_cell_mask_preview = image_global...
        > (mean_integrated_noDC_FLIM+stddev_integrated_noDC_FLIM*std_scaling_factor);

% Erode and dilate the binary masks to open connections
se = strel('disk',3);   % consider add a editable factor for the se size
dead_cell_mask_preview = imopen(dead_cell_mask_preview,se);

% Label regions in the masks and filter them by size (y~?)
labeled_dead_cell_mask_preview = bwlabel(dead_cell_mask_preview);
labeled_stats = regionprops(labeled_dead_cell_mask_preview,'Area');
    
index = find([labeled_stats.Area] >= min_deadcell_area);
dead_cell_mask_preview = ismember(labeled_dead_cell_mask_preview,index);

% Dilate the regions again for better coverage
dead_cell_mask_preview = imdilate(dead_cell_mask_preview,se);
dead_cell_mask_preview = imdilate(dead_cell_mask_preview,se);

mask_green = cat(3, zeros(size(dead_cell_mask_preview)), ones(size(dead_cell_mask_preview)).*double(dead_cell_mask_preview), zeros(size(dead_cell_mask_preview)))*0.5;
image_rgb = cat(3, ones(size(image_global)).*double(image_global), ones(size(image_global)).*double(image_global), ones(size(image_global)).*double(image_global))./double(max(image_global(:)));

image_mask = image_rgb*2 + mask_green;
imshow(image_mask, 'Parent', handles.axes1); % Only showing the dead cell masks, not showing the nth mask.



% --- Executes on button press in pushbutton_dead_cell_masks_perform.
function pushbutton_dead_cell_masks_perform_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dead_cell_masks_perform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global integrated_noDC_FLIM_folder dead_cell_masks_folder flag_dead_cell...
    mean_integrated_noDC_FLIM stddev_integrated_noDC_FLIM;
if ~exist(integrated_noDC_FLIM_folder, 'dir')
    errordlg('Please select a folder containing the integrated DC-subtracted FLIM images!','Error');
    return;
end

cd(integrated_noDC_FLIM_folder);
integrated_noDC_FLIM_list = dir('*.tiff');
num_integrated_noDC_FLIM_files = length(integrated_noDC_FLIM_list);

integrated_noDC_FLIM_reader = bfGetReader(integrated_noDC_FLIM_list(1).name);
rows_FLIM = integrated_noDC_FLIM_reader.getSizeY();
cols_FLIM = integrated_noDC_FLIM_reader.getSizeX();
integrated_noDC_FLIM_reader.close();

integrated_noDC_FLIM = uint32(zeros(rows_FLIM,cols_FLIM,num_integrated_noDC_FLIM_files)); 

% Make integrated FLIM images
for loop_FLIM_list = 1:num_integrated_noDC_FLIM_files
    % Get reader for each image, then store all images in the same matrix
    integrated_noDC_FLIM_reader = bfGetReader(integrated_noDC_FLIM_list(loop_FLIM_list).name);
  
    integrated_noDC_FLIM(:,:,loop_FLIM_list) = bfGetPlane(integrated_noDC_FLIM_reader,1);
      
    integrated_noDC_FLIM_reader.close();
end

if flag_dead_cell == 0
    % Consider all integrated images as a group and get the statistics of the
    % group
    integrated_noDC_FLIM_1D = reshape(integrated_noDC_FLIM,...
        [num_integrated_noDC_FLIM_files*rows_FLIM*cols_FLIM,1]);  % Create a 1d array to make getting the statistics easier

    mean_integrated_noDC_FLIM = mean(integrated_noDC_FLIM_1D);
    stddev_integrated_noDC_FLIM = std(single(integrated_noDC_FLIM_1D));
end

% Make binary masks based on some threshold (mean + x*std)
dead_cell_masks = uint32(zeros(rows_FLIM,cols_FLIM,num_integrated_noDC_FLIM_files)); 
labeled_dead_cell_masks = uint32(zeros(rows_FLIM,cols_FLIM,num_integrated_noDC_FLIM_files)); 

std_scaling_factor = str2double(get(handles.edit_std_scaling_factor,'String'));  % scaling factor for stddev
if isempty(std_scaling_factor)
    errordlg('Please enter a value for scaling the global stddev for thresholding!','Error');
    return;
end

min_deadcell_area = str2double(get(handles.edit_minimum_deadcell_area,'String'));
if isempty(std_scaling_factor)
    errordlg('Please enter a value for the minimum acceptable pixel area for dead cells!','Error');
    return;
end

cd(dead_cell_masks_folder);

for loop_FLIM_list = 1:num_integrated_noDC_FLIM_files
    dead_cell_masks(:,:,loop_FLIM_list) = integrated_noDC_FLIM(:,:,loop_FLIM_list)...
        > (mean_integrated_noDC_FLIM+stddev_integrated_noDC_FLIM*std_scaling_factor);    % 20151204 Note the output here is 1 instead of 255
    
    % Erode and dilate the binary masks to open connections
    se = strel('disk',3);   % consider add a editable factor for the se size
    dead_cell_masks(:,:,loop_FLIM_list) = imopen(dead_cell_masks(:,:,loop_FLIM_list),...
        se);
    
    % Label regions in the masks and filter them by size (y~?)
    labeled_dead_cell_masks(:,:,loop_FLIM_list) = bwlabel(dead_cell_masks(:,:,loop_FLIM_list));
    labeled_stats = regionprops(labeled_dead_cell_masks(:,:,loop_FLIM_list),'Area');
    
    index = find([labeled_stats.Area] >= min_deadcell_area);
    dead_cell_masks(:,:,loop_FLIM_list) = ismember(labeled_dead_cell_masks(:,:,loop_FLIM_list),index);

    % Dilate the regions again for better coverage
    dead_cell_masks(:,:,loop_FLIM_list) = imdilate(dead_cell_masks(:,:,loop_FLIM_list),...
        se);
    dead_cell_masks(:,:,loop_FLIM_list) = imdilate(dead_cell_masks(:,:,loop_FLIM_list),...
        se);
    
    % Save the masks
    save_as_OMEtiff(integrated_noDC_FLIM_list(loop_FLIM_list).name,...
        dead_cell_masks(:,:,loop_FLIM_list),[1]);    
end

listbox1_Callback(handles.listbox1, [], handles)
    
msgbox('Operation Completed','Success');



% --- Executes on button press in pushbutton_nth_preview.
function pushbutton_nth_preview_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_nth_preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global integrated_noDC_FLIM_folder dead_cell_masks_folder;

index_selected = get(handles.listbox1,'Value');
file_list = get(handles.listbox1,'String');
filename = file_list{index_selected};
image = imread(fullfile(integrated_noDC_FLIM_folder,filename));

scale = str2double(get(handles.edit_nth_scale,'String'));
rel_bg_scale = str2double(get(handles.edit_nth_rel_bg_scale,'String'));
threshold = str2double(get(handles.edit_nth_threshold,'String'));
smoothing = str2double(get(handles.edit_nth_smoothing,'String'));
min_pixel_num = str2double(get(handles.edit_nth_min_pixel_num,'String'));
%refining_factor = str2double(get(handles.edit_lower_refining_factor,'String'));
fixed_size_flag = get(handles.checkbox_fixed_region_size,'Value') == get(handles.checkbox_fixed_region_size,'Max');

nth_mask_preview = uint32(logical(nth_segmentation(double(image), scale, rel_bg_scale, threshold, smoothing, min_pixel_num, fixed_size_flag)));

if exist(dead_cell_masks_folder,'dir') && exist(fullfile(dead_cell_masks_folder,filename),'file')
    dead_cell_mask = imread(fullfile(dead_cell_masks_folder,filename));
    combined_mask = nth_mask_preview & ~dead_cell_mask;
    nth_feedback(handles, image, combined_mask);
    
    % Dilate the mask for better display
    se = strel('disk',3);
    nth_mask_preview = imdilate(nth_mask_preview,se);
    
    mask_green = cat(3, zeros(size(dead_cell_mask)), ones(size(dead_cell_mask)).*double(dead_cell_mask), zeros(size(dead_cell_mask)))*0.5;
    mask_red = cat(3, ones(size(nth_mask_preview)).*double(nth_mask_preview), zeros(size(nth_mask_preview)), zeros(size(nth_mask_preview)))*0.5;
    image_rgb = cat(3, ones(size(image)).*double(image), ones(size(image)).*double(image), ones(size(image)).*double(image))./double(max(image(:)));
    image_nth_mask = image_rgb*2 + mask_red + mask_green;
    imshow(image_nth_mask, 'Parent', handles.axes1);
else
    nth_feedback(handles, image, nth_mask_preview); % Update the statistics of the segmented regions in the nth feedback panel

    % Dilate the mask for better display
    se = strel('disk',3);
    nth_mask_preview = imdilate(nth_mask_preview,se);
    
    mask_red = cat(3, ones(size(nth_mask_preview)).*double(nth_mask_preview), zeros(size(nth_mask_preview)), zeros(size(nth_mask_preview)))*0.5;
    image_rgb = cat(3, ones(size(image)).*double(image), ones(size(image)).*double(image), ones(size(image)).*double(image))./double(max(image(:)));
    image_nth_mask = image_rgb*2 + mask_red;
    imshow(image_nth_mask, 'Parent', handles.axes1);
end



% --- Executes on button press in pushbutton_nth_perform.
function pushbutton_nth_perform_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_nth_perform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global nth_masks_folder integrated_noDC_FLIM_folder image_global;
if ~exist(nth_masks_folder,'dir')
   errordlg('The folder for storing the nth masks is not valid!','Error');
   return;
end
if ~exist(integrated_noDC_FLIM_folder,'dir')
   errordlg('The folder for storing the integrated DC_subtracted FLIM images is not valid!','Error');
   return;
end

scale = str2double(get(handles.edit_nth_scale,'String'));
rel_bg_scale = str2double(get(handles.edit_nth_rel_bg_scale,'String'));
threshold = str2double(get(handles.edit_nth_threshold,'String'));
smoothing = str2double(get(handles.edit_nth_smoothing,'String'));
min_pixel_num = str2double(get(handles.edit_nth_min_pixel_num,'String'));
%refining_factor = str2double(get(handles.edit_lower_refining_factor,'String'));
fixed_size_flag = get(handles.checkbox_fixed_region_size,'Value') == get(handles.checkbox_fixed_region_size,'Max');

cd(integrated_noDC_FLIM_folder);
integrated_noDC_FLIM_list = dir('*.tiff');
num_integrated_noDC_FLIM_files = length(integrated_noDC_FLIM_list);

for loop_FLIM_list = 1:num_integrated_noDC_FLIM_files
    cd(integrated_noDC_FLIM_folder);
    image_reader = bfGetReader(integrated_noDC_FLIM_list(loop_FLIM_list).name);
    integrated_noDC_FLIM_image = bfGetPlane(image_reader, 1);
    nth_mask = logical(nth_segmentation(double(integrated_noDC_FLIM_image), scale, rel_bg_scale, threshold, smoothing, min_pixel_num, fixed_size_flag));
    
    nth_mask = uint32(nth_mask);
    image_reader.close();
    
    cd(nth_masks_folder);
    save_as_OMEtiff(integrated_noDC_FLIM_list(loop_FLIM_list).name,nth_mask,[1]);
end

msgbox('Operation Completed','Success');
listbox1_Callback(handles.listbox1, [], handles);



% --- Executes on button press in pushbutton_combining_nth_and_dead_cells_preview.
function pushbutton_combining_nth_and_dead_cells_preview_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_combining_nth_and_dead_cells_preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global integrated_noDC_FLIM_folder dead_cell_masks_folder nth_masks_folder;

if ~exist(integrated_noDC_FLIM_folder,'dir')
   errordlg('The folder for storing the integrated DC_subtracted FLIM images is not valid!','Error');
   return;
end
if  ~exist(dead_cell_masks_folder,'dir')
    errordlg('The folder for storing the dead cell masks is not valid!','Error');
    return;
end
if  ~exist(nth_masks_folder,'dir')
    errordlg('The folder for storing the nth masks is not valid!','Error');
    return;
end

index_selected = get(handles.listbox1,'Value');
file_list = get(handles.listbox1,'String');
filename = file_list{index_selected};
image = imread(fullfile(integrated_noDC_FLIM_folder,filename));

cd(dead_cell_masks_folder);
dead_cell_mask_reader = bfGetReader(filename);
dead_cell_mask = bfGetPlane(dead_cell_mask_reader,1);

cd(nth_masks_folder);
nth_mask_reader = bfGetReader(filename);
nth_mask = bfGetPlane(nth_mask_reader,1);

lower_refining_factor = str2double(get(handles.edit_lower_refining_factor,'String'));
upper_refining_factor = str2double(get(handles.edit_upper_refining_factor,'String'));

refined_mask_preview = mask_combination_and_refining(image,dead_cell_mask,nth_mask,lower_refining_factor,upper_refining_factor);
refined_mask_preview = uint32(logical(refined_mask_preview));

nth_feedback(handles, image, refined_mask_preview);
    
% Dilate the mask for better display
se = strel('disk',3);
refined_mask_preview = imdilate(refined_mask_preview,se);
    
mask_blue = cat(3, zeros(size(dead_cell_mask)), zeros(size(dead_cell_mask)), ones(size(dead_cell_mask)).*double(refined_mask_preview))*0.5;
mask_green = cat(3, zeros(size(dead_cell_mask)), ones(size(dead_cell_mask)).*double(dead_cell_mask), zeros(size(dead_cell_mask)))*0.5;

image_rgb = cat(3, ones(size(image)).*double(image), ones(size(image)).*double(image), ones(size(image)).*double(image))./double(max(image(:)));
image_nth_mask = image_rgb*2 + mask_blue + mask_green;
imshow(image_nth_mask, 'Parent', handles.axes1);



% --- Executes on button press in pushbutton_combining_nth_and_dead_cells.
function pushbutton_combining_nth_and_dead_cells_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_combining_nth_and_dead_cells (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global integrated_noDC_FLIM_folder kinetochore_only_masks_folder dead_cell_masks_folder nth_masks_folder;

if ~exist(integrated_noDC_FLIM_folder,'dir')
   errordlg('The folder for storing the integrated DC_subtracted FLIM images is not valid!','Error');
   return;
end
if  ~exist(kinetochore_only_masks_folder,'dir')
    errordlg('The folder for storing the kinetochore-only masks is not valid!','Error');
    return;
end
if  ~exist(dead_cell_masks_folder,'dir')
    errordlg('The folder for storing the dead cell masks is not valid!','Error');
    return;
end
if  ~exist(nth_masks_folder,'dir')
    errordlg('The folder for storing the nth masks is not valid!','Error');
    return;
end

lower_refining_factor = str2double(get(handles.edit_lower_refining_factor,'String'));
upper_refining_factor = str2double(get(handles.edit_upper_refining_factor,'String'));

cd(integrated_noDC_FLIM_folder);
masks_list = dir('*.tiff');

for masks_loop = 1 : length(masks_list)
    filename = masks_list(masks_loop).name;
    
    cd(integrated_noDC_FLIM_folder);
    image_reader = bfGetReader(filename);
    image = bfGetPlane(image_reader, 1);
    
    cd(dead_cell_masks_folder);
    dead_cell_mask_reader = bfGetReader(filename);
    dead_cell_mask = bfGetPlane(dead_cell_mask_reader,1);
    
    cd(nth_masks_folder);
    nth_mask_reader = bfGetReader(filename);
    nth_mask = bfGetPlane(nth_mask_reader,1);
    
    kinetochore_only_mask = mask_combination_and_refining(image,dead_cell_mask,nth_mask,lower_refining_factor,upper_refining_factor);
    kinetochore_only_mask = uint32(logical(kinetochore_only_mask));
    cd(kinetochore_only_masks_folder);
    save_as_OMEtiff(filename,kinetochore_only_mask,[1]);
end

msgbox('Operation Completed','Success');
listbox1_Callback(handles.listbox1, [], handles);



% --- Executes on button press in pushbutton_delete_raw_image.
function pushbutton_delete_raw_image_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete_raw_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global raw_FLIM_folder integrated_noDC_FLIM_folder nth_masks_folder dead_cell_masks_folder tvb_subtracted_images_folder;

if  ~exist(raw_FLIM_folder,'dir')
    errordlg('The folder for storing raw FLIM images is not valid!','Error');
    return;
end
if  ~exist(integrated_noDC_FLIM_folder,'dir')
    errordlg('The folder for storing integrated DC_subtracted FLIM images is not valid!','Error');
    return;
end

index_selected = get(handles.listbox1,'Value');
file_list = get(handles.listbox1,'String');
filename = file_list{index_selected};

cd(raw_FLIM_folder);
delete(filename);

cd(integrated_noDC_FLIM_folder);
delete(filename);

if exist(nth_masks_folder,'dir')
    cd(nth_masks_folder);
    if exist(filename,'file')
        delete(filename);
    end
end
if exist(dead_cell_masks_folder,'dir')
    cd(dead_cell_masks_folder);
    if exist(filename,'file')
        delete(filename);
    end
end
if exist(tvb_subtracted_images_folder,'dir')
    cd(tvb_subtracted_images_folder);
    if exist(filename,'file')
        delete(filename);
    end
end

cd(integrated_noDC_FLIM_folder);
files_integrated_noDC = dir('*.tiff');
set(handles.listbox1,'string',{files_integrated_noDC.name});
listbox1_Callback(handles.listbox1, [], handles);



% --- Executes on button press in pushbutton_tvb_subtraction.
function pushbutton_tvb_subtraction_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_tvb_subtraction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global raw_FLIM_folder kinetochore_only_masks_folder raw_DC raw_DC_folder tvb_subtracted_images_folder;

if  ~exist(raw_FLIM_folder,'dir')
    errordlg('The folder for storing raw FLIM images is not valid!','Error');
    return;
end

prebleach_num = str2double(get(handles.edit_prebleach_num,'String'));

tvb_subtraction(raw_FLIM_folder,kinetochore_only_masks_folder,raw_DC_folder,raw_DC,tvb_subtracted_images_folder,prebleach_num);

msgbox('Operation Completed','Success');



function edit_tvb_subtracted_images_folder_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tvb_subtracted_images_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tvb_subtracted_images_folder as text
%        str2double(get(hObject,'String')) returns contents of edit_tvb_subtracted_images_folder as a double


% --- Executes during object creation, after setting all properties.
function edit_tvb_subtracted_images_folder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tvb_subtracted_images_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_kinetochore_only_masks_folder_Callback(hObject, eventdata, handles)
% hObject    handle to edit_kinetochore_only_masks_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_kinetochore_only_masks_folder as text
%        str2double(get(hObject,'String')) returns contents of edit_kinetochore_only_masks_folder as a double


% --- Executes during object creation, after setting all properties.
function edit_kinetochore_only_masks_folder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_kinetochore_only_masks_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit_dead_cell_masks_folder_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dead_cell_masks_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dead_cell_masks_folder as text
%        str2double(get(hObject,'String')) returns contents of edit_dead_cell_masks_folder as a double


% --- Executes during object creation, after setting all properties.
function edit_dead_cell_masks_folder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dead_cell_masks_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nth_masks_folder_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nth_masks_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nth_masks_folder as text
%        str2double(get(hObject,'String')) returns contents of edit_nth_masks_folder as a double


% --- Executes during object creation, after setting all properties.
function edit_nth_masks_folder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nth_masks_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_integrated_noDC_folder_Callback(hObject, eventdata, handles)
% hObject    handle to edit_integrated_noDC_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_integrated_noDC_folder as text
%        str2double(get(hObject,'String')) returns contents of edit_integrated_noDC_folder as a double


% --- Executes during object creation, after setting all properties.
function edit_integrated_noDC_folder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_integrated_noDC_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_prebleach_num_Callback(hObject, eventdata, handles)
% hObject    handle to edit_prebleach_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_prebleach_num as text
%        str2double(get(hObject,'String')) returns contents of edit_prebleach_num as a double


% --- Executes during object creation, after setting all properties.
function edit_prebleach_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_prebleach_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_std_scaling_factor_Callback(hObject, eventdata, handles)
% hObject    handle to edit_std_scaling_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_std_scaling_factor as text
%        str2double(get(hObject,'String')) returns contents of edit_std_scaling_factor as a double


% --- Executes during object creation, after setting all properties.
function edit_std_scaling_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_std_scaling_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_minimum_deadcell_area_Callback(hObject, eventdata, handles)
% hObject    handle to edit_minimum_deadcell_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_minimum_deadcell_area as text
%        str2double(get(hObject,'String')) returns contents of edit_minimum_deadcell_area as a double


% --- Executes during object creation, after setting all properties.
function edit_minimum_deadcell_area_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_minimum_deadcell_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_reg_num_Callback(hObject, eventdata, handles)
% hObject    handle to edit_reg_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_reg_num as text
%        str2double(get(hObject,'String')) returns contents of edit_reg_num as a double


% --- Executes during object creation, after setting all properties.
function edit_reg_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_reg_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mean_pix_val_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mean_pix_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mean_pix_val as text
%        str2double(get(hObject,'String')) returns contents of edit_mean_pix_val as a double


% --- Executes during object creation, after setting all properties.
function edit_mean_pix_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mean_pix_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_med_pix_val_Callback(hObject, eventdata, handles)
% hObject    handle to edit_med_pix_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_med_pix_val as text
%        str2double(get(hObject,'String')) returns contents of edit_med_pix_val as a double


% --- Executes during object creation, after setting all properties.
function edit_med_pix_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_med_pix_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_max_pix_val_Callback(hObject, eventdata, handles)
% hObject    handle to edit_max_pix_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_max_pix_val as text
%        str2double(get(hObject,'String')) returns contents of edit_max_pix_val as a double


% --- Executes during object creation, after setting all properties.
function edit_max_pix_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_max_pix_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_min_pix_val_Callback(hObject, eventdata, handles)
% hObject    handle to edit_min_pix_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_min_pix_val as text
%        str2double(get(hObject,'String')) returns contents of edit_min_pix_val as a double


% --- Executes during object creation, after setting all properties.
function edit_min_pix_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_min_pix_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stddev_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stddev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stddev as text
%        str2double(get(hObject,'String')) returns contents of edit_stddev as a double


% --- Executes during object creation, after setting all properties.
function edit_stddev_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stddev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nth_scale_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nth_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nth_scale as text
%        str2double(get(hObject,'String')) returns contents of edit_nth_scale as a double


% --- Executes during object creation, after setting all properties.
function edit_nth_scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nth_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nth_rel_bg_scale_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nth_rel_bg_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nth_rel_bg_scale as text
%        str2double(get(hObject,'String')) returns contents of edit_nth_rel_bg_scale as a double


% --- Executes during object creation, after setting all properties.
function edit_nth_rel_bg_scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nth_rel_bg_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nth_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nth_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nth_threshold as text
%        str2double(get(hObject,'String')) returns contents of edit_nth_threshold as a double


% --- Executes during object creation, after setting all properties.
function edit_nth_threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nth_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nth_smoothing_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nth_smoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nth_smoothing as text
%        str2double(get(hObject,'String')) returns contents of edit_nth_smoothing as a double


% --- Executes during object creation, after setting all properties.
function edit_nth_smoothing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nth_smoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nth_min_pixel_num_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nth_min_pixel_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nth_min_pixel_num as text
%        str2double(get(hObject,'String')) returns contents of edit_nth_min_pixel_num as a double


% --- Executes during object creation, after setting all properties.
function edit_nth_min_pixel_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nth_min_pixel_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_fixed_region_size.
function checkbox_fixed_region_size_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_fixed_region_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_fixed_region_size




function edit_lower_refining_factor_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lower_refining_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lower_refining_factor as text
%        str2double(get(hObject,'String')) returns contents of edit_lower_refining_factor as a double


% --- Executes during object creation, after setting all properties.
function edit_lower_refining_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lower_refining_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_upper_refining_factor_Callback(hObject, eventdata, handles)
% hObject    handle to edit_upper_refining_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_upper_refining_factor as text
%        str2double(get(hObject,'String')) returns contents of edit_upper_refining_factor as a double


% --- Executes during object creation, after setting all properties.
function edit_upper_refining_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_upper_refining_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
