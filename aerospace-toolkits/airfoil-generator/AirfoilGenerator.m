%{
	NACA 4 SERIES AIRFOIL GENERATOR
	NIRANJAN R
	CB.EN.U4AEE12029
%}
function varargout = AirfoilGenerator(varargin)
% GENERATOR MATLAB code for generator.fig
%      GENERATOR, by itself, creates a new GENERATOR or raises the existing
%      singleton*.
%
%      H = GENERATOR returns the handle to a new GENERATOR or the handle to
%      the existing singleton*.
%
%      GENERATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GENERATOR.M with the given input arguments.
%
%      GENERATOR('Property','Value',...) creates a new GENERATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before generator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to generator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help generator

% Last Modified by GUIDE v2.5 08-Apr-2014 19:35:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @generator_OpeningFcn, ...
                   'gui_OutputFcn',  @generator_OutputFcn, ...
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


% --- Executes just before generator is made visible.
function generator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to generator (see VARARGIN)

% Choose default command line output for generator
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
clear all;
clc;
global custom;
custom=0;

% UIWAIT makes generator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = generator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in series_selecter.
function series_selecter_Callback(hObject, eventdata, handles)
% hObject    handle to series_selecter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns series_selecter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from series_selecter
global custom;
popup_sel_index = get(hObject, 'Value');
switch popup_sel_index
    case 1
       custom=0;
       set(handles.max_camber_txt,'Enable','off');
       set(handles.camber_pos_txt,'Enable','off');
       set(handles.max_thickness_txt,'Enable','off');
       set(handles.max_camber,'Enable','off');
       set(handles.camber_pos,'Enable','off');
       set(handles.max_thickness,'Enable','off');
       
       set(handles.airfoil_name_txt,'Enable','on');
       set(handles.naca_txt,'Enable','on');
       set(handles.airfoil_name,'Enable','on');
    case 2
       custom=1;
       set(handles.max_camber_txt,'Enable','on');
       set(handles.camber_pos_txt,'Enable','on');
       set(handles.max_thickness_txt,'Enable','on');
       set(handles.max_camber,'Enable','on');
       set(handles.camber_pos,'Enable','on');
       set(handles.max_thickness,'Enable','on');
       
       set(handles.airfoil_name_txt,'Enable','off');
       set(handles.naca_txt,'Enable','off');
       set(handles.airfoil_name,'Enable','off');
end

% --- Executes during object creation, after setting all properties.
function series_selecter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to series_selecter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function airfoil_name_Callback(hObject, eventdata, handles)
% hObject    handle to airfoil_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of airfoil_name as text
%        str2double(get(hObject,'String')) returns contents of airfoil_name as a double


% --- Executes during object creation, after setting all properties.
function airfoil_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to airfoil_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in generate_plot_btn.
function generate_plot_btn_Callback(hObject, eventdata, handles)
% hObject    handle to generate_plot_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.graph);
axes(handles.graph);
hold on;
set(handles.generate_csv_btn,'Enable','off');
set(hObject,'Enable','off');
set(handles.generate_status,'String',sprintf('Generating NACA%s Airfoil...',get(handles.airfoil_name,'String')));
set(handles.generate_status,'Visible','on');
set(handles.graph,'Visible','on');
global h;
h = waitbar(0,'Initializing...','CreateCancelBtn','setappdata(gcbf,''cancel'',1)');
setappdata(h,'cancel',0);

% MAIN AIRFOIL GENERATOR
% PROGRAM CONFIGS
precision=str2double(get(handles.accuracy,'String'));
global airfoil custom;
airfoil={0,0};
i=1;
x_old=0;
y_old=0;
y_max=0;
y_min=0;
% NACA 4-DIGIT SERIES NUMBER (user-defined)
naca=get(handles.airfoil_name,'String');

% AIRFOIL CHORD c (user-defined)
c=1; 
waitbar(0,h,'Generating Mean camber line...')
% AIRFOIL PARAMETERS (calculated)

if(custom==0)
    m=(str2double(naca(1))/100)*c;              % MAXIMUM CAMBER (in percentage of chord c)
    p=(str2double(naca(2))/10)*c;               % POSITION OF MAXIMUM CAMBER (in tenths of chord c)
    t=(str2double([naca(3),naca(4)])/100)*c;    % MAXIMUM THICKNESS (in percentage of chord c)
else
    m=(str2double(get(handles.max_camber,'String'))/100)*c;     % MAXIMUM CAMBER (in percentage of chord c)
    p=(str2double(get(handles.camber_pos,'String'))/100)*c;     % POSITION OF MAXIMUM CAMBER (in percentage of chord c)
    t=(str2double(get(handles.max_thickness,'String'))/100)*c;	% MAXIMUM THICKNESS (in percentage of chord c)    
end
% PREPARE FIGURE FOR PLOTTING
where2plot=handles.graph;

% CALCULATE AND PLOT THE MEAN CHAMBER LINE

x=0:precision:p;
Yc=(m/(p^2))*(2*p*x-x.^2); % FOR x=0:p
plot(where2plot,x,Yc);
waitbar(0.5,h,'Generating Mean camber line...')
x=p:precision:c;
Yc=(m/(1-p)^2)*((1-2*p)+2*p*x-x.^2); % FOR x=p:c
plot(where2plot,x,Yc);
waitbar(1,h,'Done generating Mean camber line...')


% CALCULATE AND PLOT THE AIRFOIL SHAPE CO-ORDINATES

% FOR UPPER SURFACE (ABOVE MEAN CAMBER LINE)
waitbar(0,h,'Plotting airfoil shape')
for x=0:precision:p
    try
        if getappdata(h,'cancel')
            waitbar(1,h,'Cancelling...')
            break
        end
    catch err
        % DO NOTHING
    end
    
    
    theta=atan((m*(2*p - 2*x))/p^2);
    YtU=(t/0.2)*(0.2969*sqrt(x)-0.1260*x-0.3516*x.^2+0.2843*x.^3-0.1015*x.^4);
    Yc=(m/(p^2))*(2*p*x-x.^2);
    
    xU=x-YtU*sin(theta);
    yU=Yc+YtU*cos(theta);
    
    airfoil{i,1}=xU;
    airfoil{i,2}=yU;
    i=i+1;
    
    plot(where2plot,[x_old xU],[y_old yU],'b');

    x_old=xU;
    y_old=yU;
    
    waitbar(x/c,h,sprintf('Plotting the upper surface of the airfoil (%g,%g)',xU,yU))
    
    if(x==p)
        y_max=yU;
    end
end
newc=c+0.009;
for x=p:precision:newc
    try
        if getappdata(h,'cancel')
            waitbar(1,h,'Cancelling...')
            break
        end
    catch err
        % DO NOTHING
    end
        
    
    theta=atan((m*(2*p - 2*x))/(p - 1)^2);
    YtU=(t/0.2)*(0.2969*sqrt(x)-0.1260*x-0.3516*x.^2+0.2843*x.^3-0.1015*x.^4);
    Yc=(m/(1-p)^2)*((1-2*p)+2*p*x-x.^2);
    
    xU=x-YtU*sin(theta);
    yU=Yc+YtU*cos(theta);
    airfoil{i,1}=xU;
    airfoil{i,2}=yU;
    i=i+1;
    plot(where2plot,[x_old xU],[y_old yU],'b');
    x_old=xU;
    y_old=yU;
    waitbar(x/c,h,sprintf('Plotting the upper surface of the airfoil (%g,%g)',xU,yU))
end
waitbar(0,h,sprintf('Plotting the lower surface of the airfoil'));
% FOR LOWER SURFACE (BELOW MEAN CAMBER LINE)
%x_old=0;
%y_old=0;
for x=newc:-precision:p
    try
        if getappdata(h,'cancel')
            waitbar(1,h,'Cancelling...')
            break
        end
    catch err %#ok<*NASGU>
        
    end
    theta=atan((m*(2*p - 2*x))/(p - 1)^2);
    YtL=((t/0.2)*(0.2969*sqrt(x)-0.1260*x-0.3516*x.^2+0.2843*x.^3-0.1015*x.^4));
    Yc=(m/(1-p)^2)*((1-2*p)+2*p*x-x.^2);
    
    xL=x+YtL*sin(theta);
    yL=Yc-YtL*cos(theta);
    
    airfoil{i,1}=xL;
    airfoil{i,2}=yL;
    i=i+1;
    
    plot(where2plot,[x_old xL],[y_old yL],'b');
    x_old=xL;
    y_old=yL;
    waitbar(newc-x/newc,h,sprintf('Plotting the lower surface of the airfoil (%g,%g)',xL,yL))
    
end

for x=p:-precision:0
    if getappdata(h,'cancel')
        waitbar(1,h,'Cancelling...')
        break
    end
    
    theta=atan((m*(2*p - 2*x))/p^2);
    YtL=((t/0.2)*(0.2969*sqrt(x)-0.1260*x-0.3516*x.^2+0.2843*x.^3-0.1015*x.^4));
    Yc=(m/(p^2))*(2*p*x-x.^2);
    
    xL=x+YtL*sin(theta);
    yL=Yc-YtL*cos(theta);
    
    airfoil{i,1}=xL;
    airfoil{i,2}=yL;
    i=i+1;

    plot(where2plot,[x_old xL],[y_old yL],'b');
    x_old=xL;
    y_old=yL;
    waitbar(newc-x/c,h,sprintf('Plotting the lower surface of the airfoil (%g,%g)',xL,yL))
    if(x==p)
        y_min=yL;
    end
end

airfoil=cell2mat(airfoil);
airfoil(isnan(airfoil(:,1)),:)=[];
waitbar(1,h,sprintf('Plotting completed'));

set(handles.generate_status,'Visible','off');
set(hObject,'Enable','on');
try
    if getappdata(h,'cancel')
        delete(h);
        set(handles.generate_status,'Visible','on');
        set(handles.generate_status,'String','Airfoil Plot incomplete. Please Plot again to get complete airfoil.');
    else
        delete(h);
        set(handles.generate_csv_btn,'Enable','on');
    end
catch err
    % DO NOTHING
end
try
axis(where2plot,[0 newc y_min-0.1 y_max+0.1])
catch err %#ok<NASGU>
    %disp('Exception:');
    %disp('==========');
    %disp(err);
end


% --- Executes on button press in generate_csv_btn.
function generate_csv_btn_Callback(hObject, eventdata, handles)
% hObject    handle to generate_csv_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global airfoil;
dir=uigetdir('','Select where to store the csv file');
fullfile(dir,sprintf('naca%s.csv',get(handles.airfoil_name,'String')));
try
    csvwrite(fullfile(dir,sprintf('naca%s.csv',get(handles.airfoil_name,'String'))),airfoil);
    set(handles.generate_status,'String',sprintf('.csv stored in %s\\naca%s.csv',dir,get(handles.airfoil_name,'String')));
    set(handles.generate_status,'Visible','on');
catch err %#ok<NASGU>
    fprintf('\nLOG :: %f :: CSVWRITE CANCELLED BY USER\n',now);
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function accuracy_Callback(hObject, eventdata, handles)
% hObject    handle to accuracy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of accuracy as text
%        str2double(get(hObject,'String')) returns contents of accuracy as a double


% --- Executes during object creation, after setting all properties.
function accuracy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accuracy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_camber_Callback(hObject, eventdata, handles)
% hObject    handle to max_camber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_camber as text
%        str2double(get(hObject,'String')) returns contents of max_camber as a double


% --- Executes during object creation, after setting all properties.
function max_camber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_camber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function camber_pos_Callback(hObject, eventdata, handles)
% hObject    handle to camber_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of camber_pos as text
%        str2double(get(hObject,'String')) returns contents of camber_pos as a double


% --- Executes during object creation, after setting all properties.
function camber_pos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to camber_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to max_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_thickness as text
%        str2double(get(hObject,'String')) returns contents of max_thickness as a double


% --- Executes during object creation, after setting all properties.
function max_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
global h;
try
    delete(h);
catch err %#ok<NASGU>
    %
end
delete(hObject);
