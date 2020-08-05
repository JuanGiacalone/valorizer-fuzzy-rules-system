%                                       Sistema varolizador de PC´s                                                        %

%   Sistema de inferencia difusa tipo Mamdani %

%   TP - FINAL - Inteligencia Artificial 1 - Lic. en Informática %

%   Universidad Atlántida Argentina %

%   Fecha de inicio = Julio 2020 || Fecha de entrega =  3 de Agosto de 2020 %

%   Alumno = Giacalone Juan Pablo || DNI = 40.666.502 %

%   INPUTS %

   % [ %VALOR_PSU %ANTIGUEDAD %NUCLEOS; ] %
   
% Funcionamiento del sistema en la funcion =  " pushbutton2_Callback "
   
function varargout = sist_valorizador_GiacaloneJP(varargin)
% SIST_VALORIZADOR_GIACALONEJP MATLAB code for sist_valorizador_GiacaloneJP.fig
%      SIST_VALORIZADOR_GIACALONEJP, by itself, creates a new SIST_VALORIZADOR_GIACALONEJP or raises the existing
%      singleton*.
%
%      H = SIST_VALORIZADOR_GIACALONEJP returns the handle to a new SIST_VALORIZADOR_GIACALONEJP or the handle to
%      the existing singleton*.
%
%      SIST_VALORIZADOR_GIACALONEJP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIST_VALORIZADOR_GIACALONEJP.M with the given input arguments.
%
%      SIST_VALORIZADOR_GIACALONEJP('Property','Value',...) creates a new SIST_VALORIZADOR_GIACALONEJP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sist_valorizador_GiacaloneJP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sist_valorizador_GiacaloneJP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sist_valorizador_GiacaloneJP

% Last Modified by GUIDE v2.5 01-Aug-2020 18:47:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sist_valorizador_GiacaloneJP_OpeningFcn, ...
                   'gui_OutputFcn',  @sist_valorizador_GiacaloneJP_OutputFcn, ...
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

       
    

% --- Executes just before sist_valorizador_GiacaloneJP is made visible.
function sist_valorizador_GiacaloneJP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sist_valorizador_GiacaloneJP (see VARARGIN)

% Choose default command line output for sist_valorizador_GiacaloneJP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sist_valorizador_GiacaloneJP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sist_valorizador_GiacaloneJP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

    
    %   Obtengo entradas
    Valor_PSU =  str2double(get(handles.edit1,'String')) ;
    Antiguedad = str2double (get(handles.edit2,'String'));
    Nucleos = str2double(get(handles.edit3,'String')) ;
    %   Obtengo entradas
    
   % Armo array de entradas 
   inputs = [ Valor_PSU Antiguedad Nucleos ];
               
   % Muestro entradas en consola
   disp(inputs)
   
   % Importo archivo .fis de la raíz
   sistema_valorizador = readfis('sistema_valorizador_v0.26');
   
   % Calculo la salida utilizando .defuzzMethod = 'centroid' ( default )
   Valor = evalfis (inputs,sistema_valorizador);
   
   % Modifico variable del sistema y re-evaluo
   sistema_valorizador.defuzzMethod = 'bisector';
   Valor_bis= evalfis (inputs,sistema_valorizador);
   
   % Modifico variable del sistema y re-evaluo
   sistema_valorizador.defuzzMethod = 'mom';
   Valor_mom= evalfis (inputs,sistema_valorizador);
   
   % Modifico variable del sistema y re-evaluo
   sistema_valorizador.defuzzMethod = 'som';
   Valor_som= evalfis (inputs,sistema_valorizador);
   
   % Modifico variable del sistema y re-evaluo
   
   %sistema_valorizador.defuzzMethod = 'lom';   % Se quitó ya que su
   %resultado suele pisar al bisector...
   %Valor_lom= evalfis (inputs,sistema_valorizador);
   
   % Entrega la Variable valor a la caja de texto...
   set(handles.edit4,'String',Valor);
   
   % Ploteo las funciones de pertenencia de las salidas
   plotmf(sistema_valorizador,'output',1)
   
   % modifico el limite de visualizacion
   ylim([-.5 1])
  
   % Dibujo lineas para cada resultado de de-fuzzy-ficacion...
   line([Valor Valor],[-0.1 1.1],'Color','r','LineWidth',3)
   text(Valor,-0.3,' Centroide ','FontWeight','bold','Color','r')
   
   line([Valor_bis Valor_bis],[-0.2 1.1],'Color','g','LineWidth',2)
   text(Valor_bis,-0.4,' Bisector ','FontWeight','bold','Color','g')
   
   line([Valor_mom Valor_mom],[-0.2 1.1],'Color','b','LineWidth',2)
   text(Valor_mom,-0.5,' MoM ','FontWeight','bold','Color','b')
   
   line([Valor_som Valor_som],[-0.2 1.1],'Color','cyan','LineWidth',2)
   text(Valor_som,-0.6,' SoM ','FontWeight','bold','Color','cyan')
   
   %line([Valor_bis Valor_bis],[-0.2 1.1],'Color','m','LineWidth',2)
   %text(Valor_lom,-0.7,' LoM ','FontWeight','bold','Color','g')
   
   



   
   
   

function edit1_Callback(hObject, eventdata, handles)
    
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA
%returns contents of edit1 as text



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
str2double(get(hObject,'String')) 

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
str2double(get(hObject,'String')) 

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles,data)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
        

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
