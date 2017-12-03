function varargout = Hacka(varargin)
% HACKA MATLAB code for Hacka.fig
%      HACKA, by itself, creates a new HACKA or raises the existing
%      singleton*.
%
%      H = HACKA returns the handle to a new HACKA or the handle to
%      the existing singleton*.
%
%      HACKA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HACKA.M with the given input arguments.
%
%      HACKA('Property','Value',...) creates a new HACKA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Hacka_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Hacka_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Hacka

% Last Modified by GUIDE v2.5 03-Dec-2017 00:38:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Hacka_OpeningFcn, ...
                   'gui_OutputFcn',  @Hacka_OutputFcn, ...
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


% --- Executes just before Hacka is made visible.
function Hacka_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Hacka (see VARARGIN)
movegui ('center');
jFrame=get(handles.figure1,'javaframe');
jicon=javax.swing.ImageIcon('icon.gif');
jFrame.setFigureIcon(jicon);
% Choose default command line output for Hacka
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Hacka wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Hacka_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function load_Callback(hObject, eventdata, handles)
[filename pathname] = uigetfile({'*.dcm'},'File Selector');
global myString
a = [ pathname filename];

if isequal(filename,0) || isequal(pathname,0)
    uiwait(msgbox ('Por favor selecione uma imagem!','Atenção','Warn'));
    hold on;
else
    info = dicominfo(a);
    b = uint16(dicomread(a));
    axes(handles.axes2);
    imshow(b,[]);
    set(handles.pushbutton1,'Enable','on')
    myString = info.AccessionNumber;
    set(handles.text4,'String', myString);
end



% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global myString
url = strcat('http://ec2-54-86-129-169.compute-1.amazonaws.com/dasaHack/app_dev.php/questionario/',myString);
web (url, '-browser' );



% --- Executes during object creation, after setting all properties.
function text4_CreateFcn(hObject, eventdata, handles)
