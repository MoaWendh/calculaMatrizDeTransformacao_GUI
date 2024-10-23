function varargout = calcula_MatrizDeTransformacao_GUI(varargin)
% CALCULA_MATRIZDETRANSFORMACAO_GUI MATLAB code for calcula_MatrizDeTransformacao_GUI.fig
%      CALCULA_MATRIZDETRANSFORMACAO_GUI, by itself, creates a new CALCULA_MATRIZDETRANSFORMACAO_GUI or raises the existing
%      singleton*.
%
%      H = CALCULA_MATRIZDETRANSFORMACAO_GUI returns the handle to a new CALCULA_MATRIZDETRANSFORMACAO_GUI or the handle to
%      the existing singleton*.
%
%      CALCULA_MATRIZDETRANSFORMACAO_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALCULA_MATRIZDETRANSFORMACAO_GUI.M with the given input arguments.
%
%      CALCULA_MATRIZDETRANSFORMACAO_GUI('Property','Value',...) creates a new CALCULA_MATRIZDETRANSFORMACAO_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before calcula_MatrizDeTransformacao_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to calcula_MatrizDeTransformacao_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help calcula_MatrizDeTransformacao_GUI

% Last Modified by GUIDE v2.5 11-Oct-2024 18:34:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @calcula_MatrizDeTransformacao_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @calcula_MatrizDeTransformacao_GUI_OutputFcn, ...
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


% --- Executes just before calcula_MatrizDeTransformacao_GUI is made visible.
function calcula_MatrizDeTransformacao_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to calcula_MatrizDeTransformacao_GUI (see VARARGIN)

handles.pathToRead= 'C:\Users\mwend\OneDrive\Particulares\Projetos\Matlab\programas_GUI\calculaMatrizDeTransformacao_GUI\in';
handles.pathToSave= 'C:\Users\mwend\OneDrive\Particulares\Projetos\Matlab\programas_GUI\calculaMatrizDeTransformacao_GUI\out';
handles.pathToSaveFigure= 'C:\Users\mwend\OneDrive\Particulares\Projetos\Matlab\programas_GUI';

handles.PC_Referencia_Carregada= 0;
handles.PCs_ParaReferenciamento_Carregadas= 0;


% Choose default command line output for calcula_MatrizDeTransformacao_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes calcula_MatrizDeTransformacao_GUI wait for user response (see UIRESUME)
% uiwait(handles.figureMain);


% --- Outputs from this function are returned to the command line.
function varargout = calcula_MatrizDeTransformacao_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pbClose.
function pbClose_Callback(hObject, eventdata, handles)
% hObject    handle to pbClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.figureMain.HandleVisibility= 'on';

close all;
clear;
clc;


% --- Executes on button press in pbLoadPC_Referencia.
function pbLoadPC_Referencia_Callback(hObject, eventdata, handles)
% hObject    handle to pbLoadPC_Referencia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Abre tela para escolhar as PCs para serem filtradas:

clc;
close all;

if handles.PCs_ParaReferenciamento_Carregadas
    % Método para apagar uma variável de handles:
    handles= rmfield(handles, 'pcsParaReferenciar');
    handles.PCs_ParaReferenciamento_Carregadas= 0;
end

file= fullfile(handles.pathToRead, '*.txt');
[nameFile pathToRead]= uigetfile(file, 'Escolha a PC de referênica.');

if ~pathToRead
    msg= sprintf('Processo de escolha da PC de referência foi cancelado!');
    msgbox(msg, '', 'warn');
    return;
end

handles.pathToRead= pathToRead;

fileName= fullfile(pathToRead, nameFile);

% Carrega a PC de referênica:
handles.pcRef= load(fileName);

handles.PC_Referencia_Carregada= 1;

if handles.PCs_ParaReferenciamento_Carregadas
    clearvars -global handles.pcsParaReferenciar;
end

handles.pbLoadPC_ParaReferenciar.Enable= 'on';

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pbLoadPC_ParaReferenciar.
function pbLoadPC_ParaReferenciar_Callback(hObject, eventdata, handles)
% hObject    handle to pbLoadPC_ParaReferenciar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clc;
close all;

if handles.PCs_ParaReferenciamento_Carregadas
    % Método para apagar uma variável de handles:
    handles= rmfield(handles, 'pcsParaReferenciar');
end

path= fullfile(handles.pathToRead,'*.txt');
[nameFile pathToRead]= uigetfile(path, 'Escolha as PCs a serem referenciadas.', 'MultiSelect', 'on');

if ~pathToRead
    msg= sprintf('Processo de escolha do arquivo foi cancelado!');
    msgbox(msg, '', 'warn');
    return;
end
handles.pathToRead= pathToRead;

if ~iscell(nameFile)
   numFiles= 1;
else
   numFiles= size(nameFile, 2); 
end

% Carrega as PCs a serem referenciadas:
for ctFile=1:numFiles
    if numFiles==1
        fileName= fullfile(pathToRead, nameFile);
        handles.pcsParaReferenciar{ctFile}= load(fileName);    
    else    
        fileName= fullfile(pathToRead, nameFile{ctFile});
        handles.pcsParaReferenciar{ctFile}= load(fileName);
    end
end

handles.pontos2D_R_Ok= 1;

if handles.PC_Referencia_Carregada
    handles.pbCalculaTransformacao.Enable= 'on';   
end

handles.PCs_ParaReferenciamento_Carregadas= 1;
handles.pbShowPC_Transformada.Enable= 'on';

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in pbCalculaTransformacao.
function pbCalculaTransformacao_Callback(hObject, eventdata, handles)
% hObject    handle to pbCalculaTransformacao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;

% Chama função para determinar as matrizes de transformação M:
[handles.M handles.pcTransformada handles.RMSE]= fAplicaTransformacaoDeCorpoRigido(handles.pcRef, handles.pcsParaReferenciar, ... 
                                                                                  handles.pathToSave, ...
                                                                                  handles.HabRANSAC, ...
                                                                                  handles.DistanciaMaxima, ...
                                                                                  handles.NumMaxIteracoes);

% Salva as matrizes de tranformação M:
if handles.HabSaveMatrizTransformacao
    path= uigetdir(handles.pathToSave, 'Escolha o local para salvar as transformações');
    if ~path
        msg= sprintf('Eacolha cancelada.');
        msgbox(msg, '', 'warn');
        return;
    end
    handles.pathToSave= path;
    
    % Chama função para salvar a matriz de transfomração se esta função estiver habilitada:
    fSalvaMatrizM(handles.M, path);
end

handles.RMSE_total= sum(handles.RMSE)/length(handles.RMSE);

msg= sprintf('Foram calculadas %d transformações.\nErro quadrático total= %.3f', length(handles.M), handles.RMSE_total);
uiwait(msgbox(msg, 'Ok', 'modal'));

handles.pbShowPC_Transformada.Enable= 'on';
handles.pbTesteMatrizM.Enable= 'on';

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in pbShowPC_Transformada.
function pbShowPC_Transformada_Callback(hObject, eventdata, handles)
% hObject    handle to pbShowPC_Transformada (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.pathToSaveFigure= fShowPCs(handles.pcRef, handles.pcsParaReferenciar, handles.pcTransformada, ...
                                   handles.HabSalvarGraficos, handles.pathToSaveFigure, handles.RMSE_total);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3

handles.HabSaveMatrizTransformacao= hObject.Value;

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function radiobutton3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.HabSaveMatrizTransformacao= hObject.Value;

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in pbTesteMatrizM.
function pbTesteMatrizM_Callback(hObject, eventdata, handles)
% hObject    handle to pbTesteMatrizM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clc;
close all;

% Escolhe uma PC de referência para o registro:
path= fullfile(handles.pathToRead,'*.txt');
[nameFile pathToRead]= uigetfile(path, 'Escolha a PC de referência.');
if ~pathToRead
    msg= sprintf('Processo de escolha da PC foi cancelado!');
    msgbox(msg, '', 'warn');
    return;
end
handles.pathToRead= pathToRead;
nameFile= fullfile(pathToRead, nameFile);
pcRef= load(nameFile); 

% Escolhe uma PC qualquer para ser registrada:
path= fullfile(handles.pathToRead,'*.txt');
[nameFile pathToRead]= uigetfile(path, 'Escolha a PC a ser registrada.');

if ~pathToRead
    msg= sprintf('Processo de escolha da PC foi cancelado!');
    msgbox(msg, '', 'warn');
    return;
end
handles.pathToRead= pathToRead;
nameFile= fullfile(pathToRead, nameFile);
pcParaRegistrar= load(nameFile); 


% Define a matriz de transformação entre as duas PCs escolhidas acima:
path= fullfile(handles.pathToRead,'*.txt');
[nameFile pathToRead]= uigetfile(path, 'Defina a matriz de transformação M.');

if ~pathToRead
    msg= sprintf('Processo de escolha da PC foi cancelado!');
    msgbox(msg, '', 'warn');
    return;
end
handles.pathToRead= pathToRead;
nameFile= fullfile(pathToRead, nameFile);
M= load(nameFile); 

% Chama a função para efetura o registro:
fAplicaTransformacao(M, pcRef, pcParaRegistrar);

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in rdHabRANSAC.
function rdHabRANSAC_Callback(hObject, eventdata, handles)
% hObject    handle to rdHabRANSAC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdHabRANSAC

handles.HabRANSAC= hObject.Value;

if hObject.Value
    handles.edtNumMaxIteracoes.Enable= 'on'; 
    handles.edtDistanciaMaxima.Enable= 'on'; 
else
    handles.edtNumMaxIteracoes.Enable= 'off'; 
    handles.edtDistanciaMaxima.Enable= 'off';   
end

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function rdHabRANSAC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rdHabRANSAC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.HabRANSAC= hObject.Value;

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in rdHabIgualarTamanhoDasPCs.
function rdHabIgualarTamanhoDasPCs_Callback(hObject, eventdata, handles)
% hObject    handle to rdHabIgualarTamanhoDasPCs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdHabIgualarTamanhoDasPCs

handles.HabIgualarOsTamanhosDasPCs= hObject.Value;

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function rdHabIgualarTamanhoDasPCs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rdHabIgualarTamanhoDasPCs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.HabIgualarOsTamanhosDasPCs= hObject.Value;

% Update handles structure
guidata(hObject, handles);



function edtNumMaxIteracoes_Callback(hObject, eventdata, handles)
% hObject    handle to edtNumMaxIteracoes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtNumMaxIteracoes as text
%        str2double(get(hObject,'String')) returns contents of edtNumMaxIteracoes as a double

handles.NumMaxIteracoes= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function edtNumMaxIteracoes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtNumMaxIteracoes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.NumMaxIteracoes= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);



function edtDistanciaMaxima_Callback(hObject, eventdata, handles)
% hObject    handle to edtDistanciaMaxima (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtDistanciaMaxima as text
%        str2double(get(hObject,'String')) returns contents of edtDistanciaMaxima as a double

handles.DistanciaMaxima= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edtDistanciaMaxima_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtDistanciaMaxima (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.DistanciaMaxima= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in rdSaveGraph.
function rdSaveGraph_Callback(hObject, eventdata, handles)
% hObject    handle to rdSaveGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdSaveGraph

handles.HabSalvarGraficos= hObject.Value;

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function rdSaveGraph_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rdSaveGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.HabSalvarGraficos= hObject.Value;

% Update handles structure
guidata(hObject, handles);


