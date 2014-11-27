function varargout = StressCalc(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 14-May-2014 15:01:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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
% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = main_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;



function element_number_Callback(hObject, eventdata, handles)
% TODO

function element_number_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function start_btn_Callback(hObject, eventdata, handles)

global elements yi zi ai my mz k iyy izz iyz sum_ay sum_az sum_ai

yi={0.0};
zi={0.0};
ai={0.0};
k=1;
iyy=0.0;
izz=0.0;
iyz=0.0;
sum_az=0.0;
sum_ay=0.0;
sum_ai=0.0;
elements=str2double(get(handles.element_number,'String')); %#ok<*NASGU>
my=str2double(get(handles.my_val,'String'));
mz=str2double(get(handles.mz_val,'String'));

set(handles.element_number,'Enable','off');
set(handles.my_val,'Enable','off');
set(handles.mz_val,'Enable','off');

set(handles.data_entry_panel,'Visible','on');
set(handles.start_btn,'Visible','off');
set(handles.restart,'Visible','on');





function zi_val_Callback(hObject, eventdata, handles)
% TODO

function zi_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ai_val_Callback(hObject, eventdata, handles)
% TODO

function ai_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yi_val_Callback(hObject, eventdata, handles)
% TODO

function yi_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ai_pwr_Callback(hObject, eventdata, handles)
% TODO

function ai_pwr_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yi_pwr_Callback(hObject, eventdata, handles)
% TODO

function yi_pwr_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zi_pwr_Callback(hObject, eventdata, handles)
% TODO

function zi_pwr_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function data_btn_Callback(hObject, eventdata, handles)
global elements yi zi ai my mz cy cz k iyy izz iyz sum_ay sum_az sum_ai ypart zpart table showed
showed=0;
format shortEng;
table={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
ai{k}=str2double(get(handles.ai_val,'String'))*10^str2double(get(handles.ai_pwr,'String'));
yi{k}=str2double(get(handles.yi_val,'String'))*10^str2double(get(handles.yi_pwr,'String'));
zi{k}=str2double(get(handles.zi_val,'String'))*10^str2double(get(handles.zi_pwr,'String'));



set(handles.ai_val,'String','0');
set(handles.yi_val,'String','0');
set(handles.zi_val,'String','0');

set(handles.ai_pwr,'String','0');
set(handles.yi_pwr,'String','0');
set(handles.zi_pwr,'String','0');

sum_ay=sum_ay+ai{k}*yi{k};
sum_az=sum_az+ai{k}*zi{k};
sum_ai=sum_ai+ai{k};


%disp(k);
if(k==elements)
    set(handles.start_btn,'Enable','on');
    %syms y z;
    %disp('sum_ai');
    %disp(sum_ai);
    %disp('sum_ay');
    %disp(sum_ay);
    %disp('sum_az');
    %disp(sum_az);
    cy=sum_ay/sum_ai;
    cz=sum_az/sum_ai;
    %disp('cy,cz');
    %disp(cy);
    %disp(cz);
    for j=1:1:elements
        %disp(j);
        %disp('-----');
        %disp(yi{j});
        %disp(zi{j});
        cyi=yi{j}-cy;
        czi=cz-zi{j};
        
        table{j,1}=ai{j};
        table{j,2}=yi{j};
        table{j,3}=zi{j};
        
        table{j,4}=ai{j}*yi{j};
        table{j,5}=ai{j}*zi{j};
        
        table{j,6}=cyi;
        table{j,7}=czi;
        
        %disp('cyi,czi');
        %disp(cyi);
        %disp(czi);
        %disp('-------');
        
        table{j,8}=ai{j}*cyi*czi;
        table{j,9}=ai{j}*cyi^2;
        table{j,10}=ai{j}*czi^2;
        
        iyz=iyz+ai{j}*cyi*czi;
        izz=izz+ai{j}*cyi^2;
        iyy=iyy+ai{j}*czi^2;
        
        %disp(iyz);
        %disp(izz);
        %disp(iyy);
        %disp('-------');
    end
    %disp('x,y part');
    ypart=(mz*iyy+my*iyz)/(iyy*izz-iyz^2);
    zpart=(my*izz+mz*iyz)/(iyy*izz-iyz^2);
    %disp(ypart);
    %disp(zpart);
    %disp(table);
    set(handles.show_table_btn,'Visible','on');
    
    stress=sprintf('-y(%e)+z(%e)',ypart,zpart);
    set(handles.data_entry_panel,'Visible','off');
    set(handles.result_panel,'Visible','on');
    set(handles.iyz_val,'String',iyz);
    set(handles.izz_val,'String',izz);
    set(handles.iyy_val,'String',iyy);
    set(handles.stress,'String',stress);
else
     set(handles.start_btn,'Enable','off');
     k=k+1;
end
panel_head=sprintf('Data for Element %d',k);
set(handles.data_entry_panel,'Title',panel_head);

function my_val_Callback(hObject, eventdata, handles)
% TODO

function my_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mz_val_Callback(hObject, eventdata, handles)
% TODO

function mz_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function izz_val_Callback(hObject, eventdata, handles)
% TODO

function izz_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function iyz_val_Callback(hObject, eventdata, handles)
% TODO

function iyz_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function iyy_val_Callback(hObject, eventdata, handles)
% TODO

function iyy_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stress_Callback(hObject, eventdata, handles)
% TODO

function stress_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cy_val_Callback(hObject, eventdata, handles)
% TODO

function cy_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cz_val_Callback(hObject, eventdata, handles)
% TODO

function cz_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function restart_Callback(hObject, eventdata, handles)
set(hObject,'Visible','off');
set(handles.start_btn,'Visible','on');
set(handles.show_table_btn,'Visible','off');
set(handles.data_entry_panel,'Visible','off');
set(handles.result_panel,'Visible','off');
set(handles.element_number,'Enable','on');
set(handles.my_val,'Enable','on');
set(handles.mz_val,'Enable','on');
set(handles.element_number,'String','');
set(handles.my_val,'String','');
set(handles.mz_val,'String','');
set(handles.start_btn,'Visible','on');
set(handles.start_btn,'Enable','on');
set(handles.data_entry_panel,'Title','Data for Element 1');
set(handles.table,'Visible','off');
set(handles.result_panel,'Visible','off');
set(handles.ai_val,'String','0');
set(handles.yi_val,'String','0');
set(handles.zi_val,'String','0');

set(handles.ai_pwr,'String','0');
set(handles.yi_pwr,'String','0');
set(handles.zi_pwr,'String','0');
set(handles.y_point,'String','0');
set(handles.z_point,'String','0');
set(handles.calc_stress_result,'String','');

global yi zi ai k iyy izz iyz sum_ay sum_az sum_ai showed

showed=0;

yi={0.0};
zi={0.0};
ai={0.0};
k=1;
iyy=0.0;
izz=0.0;
iyz=0.0;
sum_az=0.0;
sum_ay=0.0;
sum_ai=0.0;


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function y_point_Callback(hObject, eventdata, handles)
% hObject    handle to y_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_point as text
%        str2double(get(hObject,'String')) returns contents of y_point as a double


% --- Executes during object creation, after setting all properties.
function y_point_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z_point_Callback(hObject, eventdata, handles)
% hObject    handle to z_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z_point as text
%        str2double(get(hObject,'String')) returns contents of z_point as a double


% --- Executes during object creation, after setting all properties.
function z_point_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function calc_stress_result_Callback(hObject, eventdata, handles)
% hObject    handle to calc_stress_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of calc_stress_result as text
%        str2double(get(hObject,'String')) returns contents of calc_stress_result as a double


% --- Executes during object creation, after setting all properties.
function calc_stress_result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to calc_stress_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in calc_stress.
function calc_stress_Callback(hObject, eventdata, handles)
global ypart zpart
% hObject    handle to calc_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y_point=str2double(get(handles.y_point,'String'));
z_point=str2double(get(handles.z_point,'String'));
stress_at_point=sprintf('%e',(-y_point)*ypart+z_point*zpart);
set(handles.calc_stress_result,'String',stress_at_point);
set(handles.y_point,'Enable','on');


% --- Executes on button press in show_table_btn.
function show_table_btn_Callback(hObject, eventdata, handles)
% hObject    handle to show_table_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global table showed
if(showed==0)
    set(handles.table,'Visible','on');
    set(handles.result_panel,'Visible','off');
    set(handles.table,'Data',table);
    set(hObject,'String','Hide Table');
    showed=1;
else
    showed=0;
    set(handles.table,'Visible','off');
    set(handles.result_panel,'Visible','on');
    set(hObject,'String','Show Table');
end


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
