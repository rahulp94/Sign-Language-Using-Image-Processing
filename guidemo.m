function varargout = guidemo(varargin)
% GUIDEMO for guidemo.fig
%      GUIDEMO, by itself, creates a new GUIDEMO or raises the existing
%      singleton*.
%
%      H = GUIDEMO returns the handle to a new GUIDEMO or the handle to
%      the existing singleton*.
%
%      GUIDEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDEMO.M with the given input arguments.
%
%      GUIDEMO('Property','Value',...) creates a new GUIDEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guidemo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guidemo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% 

% Edit the above text to modify the response to help guidemo

% Last Modified by GUIDE v2.5 13-April-2016 11:10:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guidemo_OpeningFcn, ...
                   'gui_OutputFcn',  @guidemo_OutputFcn, ...
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


% --- Executes just before guidemo is made visible.
function guidemo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guidemo (see VARARGIN)

% Choose default command line output for guidemo
handles.output = hObject;
% clear;

sss='0';
set(handles.timer,'String',sss);
sss='0';
set(handles.edit2,'String',sss);
sss='0';
set(handles.edit3,'String',sss);
a=ones(256,320);
axes(handles.axes1);
imshow(a);

b=ones(256,256);
axes(handles.axes2);
imshow(b);
axes(handles.axes3);
imshow(b);
axes(handles.axes4);
imshow(b);
axes(handles.axes5);
imshow(b);
axes(handles.axes6);
imshow(b);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guidemo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guidemo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sss='Capturing Background';
set(handles.edit2,'String',sss);

vid=videoinput('winvideo',1,'YUY2_640x480'); 
set(vid,'ReturnedColorSpace','rgb');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
triggerconfig(vid,'manual'); 
%Capture one frame per trigger
set(vid,'FramesPerTrigger',1 );
set(vid,'TriggerRepeat', Inf);
start(vid); %start video

 BW = imread('mask.bmp');
 BW=im2bw(BW);
 [B,L,N,A] = bwboundaries(BW);
axes(handles.axes1);
 imshow(BW); hold on;
       for k=1:length(B),
         if(~sum(A(k,:)))
           boundary = B{k};
           axes(handles.axes1);
           plot(boundary(:,2), boundary(:,1), 'r','LineWidth',2);
           for l=find(A(:,k))'
             boundary = B{l};
             axes(handles.axes1);
             save boundary boundary
             plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
           end
         end
       end
       
       
%        imshow(AA); hold on;
load boundary       
       
aa=1;
%Infinite while loop
load r;
load c;
% r=69:400;
% c=83:500;
while(1)
% preview(vid)
%Get Image
trigger(vid);
im=getdata(vid,1);
axes(handles.axes1);
imshow(im);
hold on
if aa == 5
    red=im(:,:,1);
Green=im(:,:,2);
Blue=im(:,:,3);

Out(:,:,1)=red(min(r):max(r),min(c):max(c));
Out(:,:,2)=Green(min(r):max(r),min(c):max(c));
Out(:,:,3)=Blue(min(r):max(r),min(c):max(c));
Out=uint8(Out);
 axes(handles.axes2);
 imshow(Out);
imwrite(Out,'bg.bmp');
sss='Capturing Gesture';
set(handles.edit2,'String',sss);
   
end

axes(handles.axes1);
plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
aa=aa+1;
set(handles.timer,'String',num2str(aa));
disp(aa);
if aa == 30
   break 
end


end

stop(vid),delete(vid),clear vid; 

red=im(:,:,1);
Green=im(:,:,2);
Blue=im(:,:,3);

Out(:,:,1)=red(min(r):max(r),min(c):max(c));
Out(:,:,2)=Green(min(r):max(r),min(c):max(c));
Out(:,:,3)=Blue(min(r):max(r),min(c):max(c));
Out=uint8(Out);
imwrite(Out,'final.bmp');
%figure, 
axes(handles.axes3);
imshow(Out,[])
        a=imread('bg.bmp');
[C1,c1]=segment(a,Out);

axes(handles.axes4);
imshow(c1,[]);
axes(handles.axes5);
imshow(C1,[]);

% close all;
% figure;
str='.bmp';
str1='F'
for i=1:50
    a=strcat(num2str(i),str);
    b=imread(a);
    re1=corr2(b,C1);
      fresultValues_r(i) = re1;
    fresultNames_r(i) = {a};
  
    result1(i)=re1
%     figure;
%     subplot(1,2,1);imshow(C1);
%     subplot(1,2,2);imshow(b);
%     xlabel(re1);
end

[re ma]=max(result1);
 a=strcat(num2str(ma),str);
b=imread(a);
axes(handles.axes6);
imshow(b);title('recognition result');
    
[sortedValues_r, index_r] = sort(-fresultValues_r);     % Sorted results... the vector index

count1=0;
count2=0;
count3=0;
count4=0;
count5=0;
    fid = fopen('recognition.txt', 'w+');         % Create a file, over-write old ones.
for i = 1:10        % Store top 5 matches...
    
    
    
    imagename = char(fresultNames_r(index_r(i)));
    fprintf(fid, '%s\r', imagename);
    
    a=index_r(i)
    
    if a > 0 && a <=10
        
        count1=count1+1;
        
    elseif a > 10 && a <=20
        count2=count2+1;
    elseif a > 20 && a <=30
        count3=count3+1;
    elseif a > 30 && a <=40
        count4=count4+1;
    else
            count5=count5+1;
    end
    
    
    
end
fclose(fid);
disp('exit');

Out =[count1 count2 count3  count4  count5];

 
 [Res ind]=max(Out);
 disp(ind);
 
 



function timer_Callback(hObject, eventdata, handles)
% hObject    handle to timer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timer as text
%        str2double(get(hObject,'String')) returns contents of timer as a double


% --- Executes during object creation, after setting all properties.
function timer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timer (see GCBO)
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


% --- Executes on button press in Train.
function Train_Callback(hObject, eventdata, handles)
% hObject    handle to Train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guitrain

% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% clear;
sss='0';
set(handles.timer,'String',sss);
sss='0';
set(handles.edit2,'String',sss);
sss='0';
set(handles.edit3,'String',sss);
a=ones(480,650);
axes(handles.axes1);
imshow(a);

b=ones(256,256);
axes(handles.axes2);
imshow(b);
axes(handles.axes3);
imshow(b);
axes(handles.axes4);
imshow(b);
axes(handles.axes5);
imshow(b);
axes(handles.axes6);
imshow(b);



% --- Executes on button press in Readme.
function Readme_Callback(hObject, eventdata, handles)
% hObject    handle to Readme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpwin help1


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
exit