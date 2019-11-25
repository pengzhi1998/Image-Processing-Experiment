function varargout = try2(varargin)
%TRY2 MATLAB code file for try2.fig
%      TRY2, by itself, creates a new TRY2 or raises the existing
%      singleton*.
%
%      H = TRY2 returns the handle to a new TRY2 or the handle to
%      the existing singleton*.
%
%      TRY2('Property','Value',...) creates a new TRY2 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to try2_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      TRY2('CALLBACK') and TRY2('CALLBACK',hObject,...) call the
%      local function named CALLBACK in TRY2.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help try2

% Last Modified by GUIDE v2.5 23-Dec-2017 20:26:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @try2_OpeningFcn, ...
                   'gui_OutputFcn',  @try2_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before try2 is made visible.
function try2_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for try2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes try2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = try2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_dir.
function load_dir_Callback(hObject,~, handles)
strPath=uigetdir('F:/��ѧѧϰ����/�ź���ϵͳ','ѡ��Ŀ¼');
if~ischar(strPath)
    return
end
setappdata(hObject,'strPath',strPath);
str_jpg=dir([strPath,'\*.jpg']);
str_bmp=dir([strPath,'\*.bmp']);
str_gif=dir([strPath,'\*.gif']);
str1=[str_jpg;str_bmp;str_gif];
strAllPath=struct2cell(str1);
setappdata(hObject,'strAllPath',strAllPath);
if~isempty(str1)
    n=find(cell2mat(strAllPath(4,:))==1);
    if~isempty(n)
        strAllPath(:,n)=[];
    end
end
if~isempty(strAllPath)
    index=1;
    set(hObject,'userData',index);
    set(handles.pic_name,'string',strAllPath{1,1})
    M=imread(fullfile(strPath,strAllPath{1,index}));
    axes(handles.axes1)
    imshow(M);
    h=findall(handles.pic_menu,'type','uimenu');
    delete(h);
    for i=1:size(strAllPath,2)
        uimenu(handles.pic_menu,'label',strAllPath{1,i},'position',i,...
        'callback',{ @pic_menu_callback,handles});
    end
    set(findobj('Type','uimenu','Position',index),'Checked','on');
    set(findobj(gcf,'Type','uicontrol','Enable','inactive'),'Enable','on');
    set(findobj(gcf,'Type','uimenu','Enable','off'),'Enable','on');
end
handles.name=M;
guidata(hObject, handles);
% hObject    handle to load_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in picPre.
function picPre_Callback(hObject, eventdata, handles)
strAllPath=getappdata(handles.load_dir,'strAllPath');
strPath=getappdata(handles.load_dir,'strPath');
indexPre=get(handles.load_dir,'userData');
if indexPre>1
    index=indexPre-1;
else
    index=size(strAllPath,2);
end
set(handles.load_dir,'userData',index);
set(findobj(gcf,'Type','uimenu','Position',indexPre),'Checked','off');
set(findobj(gcf,'Type','uimenu','Position',index),'Checked','on');
cla;
M=imread(fullfile(strPath,strAllPath{1,index}));
axes(handles.axes1)
imshow(M);
% set(handles.pic_name,'string',strAllPath{1,index});
% set(handles.axes1,'colororder',[0 0 1],'units','normalized','position',[0 0 1 1]);

% hObject    handle to picPre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in picNext.
function picNext_Callback(hObject, eventdata, handles)
strAllPath=getappdata(handles.load_dir,'strAllPath');
strPath=getappdata(handles.load_dir,'strPath');
indexPre=get(handles.load_dir,'userData');
if indexPre<size(strAllPath,2)
    index=indexPre+1;
else
    index=1;
end
set(handles.load_dir,'userData',index);
set(findobj(gcf,'Type','uimenu','Position',indexPre),'Checked','off');
set(findobj(gcf,'Type','uimenu','Position',index),'Checked','on');
cla;
M=imread(fullfile(strPath,strAllPath{1,index}));
imshow(M);
set(handles.pic_name,'string',strAllPath{1,index});
% hObject    handle to picNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pic_crop.
function pic_crop_Callback(hObject, eventdata, handles)
if get(hObject,'value')
    hRect=imrect;
    pos=wait(hRect);
    delete(hRect);
    strAllPath=getappdata(handles.load_dir,'strAllPath');
    strPath=getappdata(handles.load_dir,'strPath');
    index=get(handles.load_dir,'userData');
    M=imread(fullfile(strPath,strAllPath{1,index}));
    newM=imcrop(M,pos);
    [fName,pName,index]=uiputfile({'*.jpg';'*.bmp'},'ͼƬ���Ϊ',datestr(now,30));
    if index
        strName=[pName fName];
        h=figure('visible','off');
        imshow(newM);
        if strcmp(fName(end-3:end),'.jpg')
            print(h,'-djpeg',strName);
        elseif strcmp(fName(end-3:end),'.bmp')
            print(h,'-dbmp',strName);
        end
        delete(h);
    end
    set(hObject,'value',0);
end
% hObject    handle to pic_crop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of pic_crop


% --- Executes on button press in zoom_in.
function zoom_in_Callback(~, ~, ~)
toolsmenufcn ZoomIn
% hObject    handle to zoom_in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of zoom_in


% --------------------------------------------------------------------
function tool_menu_Callback(hObject, eventdata, handles)
% hObject    handle to tool_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function load_dir_menu_Callback(hObject, eventdata, handles)
load_dir_Callback(handles.load_dir,eventdata,handles);
% hObject    handle to load_dir_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function picPre_menu_Callback(hObject, eventdata, handles)
picPre_Callback(handles.picPre,eventdata,handles);
% hObject    handle to picPre_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function picNext_menu_Callback(hObject, eventdata, handles)
picNext_Callback(handles.picNext,eventdata,handles);
% hObject    handle to picNext_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function pic_crop_menu_Callback(hObject, eventdata, handles)
val=get(handles.pic_crop,'Value');
set(handles.pic_crop,'Value',~val);
pic_crop_Callback(handles.pic_crop,eventdata,handles);
% hObject    handle to pic_crop_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function zoom_in_menu_Callback(hObject, eventdata, handles)
val=get(handles.zoom_in,'Value');
set(handles.zoom_in,'Value',~val);
zoom_in_Callback(hObject,eventdata,handles);
% hObject    handle to zoom_in_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
if(~get(handles.zoom_in,'Value'))&&(~get(handles.pic_crop,'Value'))
    pos=get(handles.axes1,'currentpoint');
    xLim=get(handles.axes1,'xlim');
    yLim=get(handles.axes1,'ylim');
    if(pos(1,1)>=xLim(1)&&pos(1,1)<=xLim(2))&&(pos(1,2)>=yLim(1)&&pos(1,2)<=yLim(2))
        set(gcf,'Pointer','hand')
    else
        set(gcf,'Pointer','arrow')
    end
end
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
if strcmp(get(gcf,'Pointer'),'hand')&&strcmp(get(handles.picNext,'Enable'),'on')
    if strcmp(get(gcf,'SelectionType'),'alt')
        pos=get(gcf,'currentpoint');
        set(handles.pic_menu,'position',[pos(1,1) pos(1,2)],'visible','on')
    elseif strcmp(get(gcf,'SelectionType'),'normal')
        picNext_Callback(hObject,eventdata,handles);
    end
end
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
switch eventdata.Key
    case{'pageup','leftarrow','uparrow'}
        picPre_Callback(handles.picPre,eventdata,handles);
    case{'pagedown','rightarrow','downarrow'}
        picNext_Callback(handles.picNext,eventdata,handles);
end
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function pic_menu_Callback(hObject, eventdata, handles)
indexPre=get(handles.load_dir,'userData');
set(findobj('Type','uimenu','Position',indexPre),'Checked','off');
index=get(obj,'position');
set(handles.load_dir,'userdata',index);
set(obj,'Checked','on');
strAllPath=getappdata(handles.load_dir,'strPath');
cla;
M=imread(fullfile(strPath,strAllPath{1,index}));
imshow(M);
% hObject    handle to pic_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function popupmenu4_Callback(hObject, eventdata, handles)
sel=get(hObject,'value');
M=handles.name;
switch sel
    case 1
        imshow(M);
        set(handles.axes1);
        
    case 2
        % I=imread(M);
        img=imresize(M,[1000,1000]);
        size_info=size(img);  
        height=size_info(1);  
        width=size_info(2);  
        N=20;  
        out=zeros(height,width,3);  
        for i=1:height  
            for j=1:width  
                temp=uint8(rand()*(N^2-1));  %rand:����0-1��������
                m=temp/N;  
                n=mod(temp,N);  %mod:ȡ��
                h=mod(double(i-1)+double(m),double(height));  %ȡ��������
                w=mod(double(j-1)+double(n),double(width));   %ȡ��������
                if w==0;  
                    w=width-500;  %��Ϊimg(0,0)���Ϸ������Ը�wȡ���������ֵ(�Ҳ����)����֤�Ϸ���
                end  
                if h==0  
                    h=height-500;  %��Ϊimg(0,0)���Ϸ������Ը�hȡ���������ֵ(�Ҳ����)����֤�Ϸ���
            
                end  
                out(i,j,:)=img(h,w,:);         
            end
        end
        spec_img=zeros(height,width,3);
        img_temp=rgb2gray(img);
        for i=2:height-1
            for j=2:width-1
                spec_img(i,j,:)=double(out(i-1,j-1))-double(out(i+1,j+1))+128;
            end
        end
        %figure();
        imshow(spec_img/255);
        set(handles.axes1);
        
    case 3%����
img=imresize(M,[1000,1000]);
size_info=size(img);
height=size_info(1);
width=size_info(2);
spec_img=zeros(height,width,3);
img_temp=rgb2gray(img);
%��ͼ����˾���Y(i,j)=X(i-1,j-1)-X(i+1,j+1)+128��
for i=2:height-1
    for j=2:width-1
        spec_img(i,j,:)=double(img_temp(i-1,j-1,:))-double(img_temp(i+1,j+1,:))+128;
    end
end
imshow(spec_img/255);
set(handles.axes1);
        
    case 4%��ɫ����
img=imresize(M,[1000,1000]);
img_r=img(:,:,1);  %��ɫ����
img_g=img(:,:,2);  %��ɫ����
img_b=img(:,:,3);  %��ɫ����
zero = zeros(size(img_r));  
R=cat(3,img_r,zero,zero);  
G=cat(3,zero,img_g,zero);
B1=cat(3,zero,zero,img_b);
RGB=cat(3,img_r,img_g,img_b);  
a=7;
b=4;
c=6;
j=3/(a+b+c);
%��ͼ����˾�����ȡRGBֵ������Ȩ��(����֤����ͼƬ���Ȳ���)��ͣ�
M=a*j*R+b*j*G+c*j*B1;
imshow(M);
set(handles.axes1);

    case 5%Ǧ�ʻ�����
        I=imresize(M,[1000,1000]);
info_size=size(I);%ͼƬ�ߴ�
height=info_size(1);%ͼƬ�߶�
width=info_size(2);%ͼƬ���
N=zeros(height,width);%height�У�width�е������
g=zeros(height,width);%height�У�width�е������
imggray=rgb2gray(I);%ȥɫ
out=zeros(height,width);%height�У�width�е������
%��ͼ����˾���ȥɫ������ȥɫͼ�㣬���ҷ�ɫ���Է�ɫͼ����и�˹ģ����ģ�����ͼ�����ģʽѡ����ɫ����Ч����
for i=1:height
    for j=1:width
        
        N(i,j)=255-imggray(i,j);%��ɫ(���ɫ���Ҷ�ֵΪ255�������任�ú�ɫ���Ҷ�ֵΪ0)
        
    end
end
for i=2:height-1
    for j=2:width-1
        sum=0;
        sum=1*double(N(i-1,j-1))+2*double(N(i-1,j))+1*double(N(i-1,j+1));
        sum=sum+2*double(N(i,j-1))+4*double(N(i,j))+2*double(N(i,j-1));
        sum=sum+1*double(N(i+1,j-1))+2*double(N(i+1,j))+1*double(N(i+1,j+1));
        sum=sum/16;
        g(i,j)=sum;
    end
end
for i=1:height
    for j=1:width
        b=double(g(i,j));%Ŀ�����ص�
        a=double(imggray(i,j));%Դ���ص�
        temp=a+a*b/(256-b);%��ɫ�������㷨
        out(i,j)=uint8(min(temp,255));%��ɫ�������㷨
    end
end
imshow(out/255);
set(handles.axes1);

    case 6%ë����
        img=imresize(M,[1000,1000]);
        size_info=size(img);  
        height=size_info(1);  
        width=size_info(2);  
        N=13;  
        out=zeros(height,width,3);  
        %��ͼ����˾����õ�ǰ������һ����Χ������һ�����ɫ�������ǰ����ɫ����õ�������Ĳ������ڵ�����������
        for i=1:height  
            for j=1:width  
                temp=uint8(rand()*(N^2-1));  %rand:����0-1��������
                m=temp/N;  
                n=mod(temp,N);  %mod:ȡ��
                h=mod(double(i-1)+double(m),double(height));  %ȡ��������
                w=mod(double(j-1)+double(n),double(width));   %ȡ��������
                if w==0;  
                    w=width-500;  %��Ϊimg(0,0)���Ϸ������Ը�wȡ���������ֵ(�Ҳ����)����֤�Ϸ���
                end  
                if h==0  
                    h=height-500;  %��Ϊimg(0,0)���Ϸ������Ը�hȡ���������ֵ(�Ҳ����)����֤�Ϸ���
                end
                out(i,j,:)=img(h,w,:);
            end
        end
        imshow(out/255);
        set(handles.axes1);
        
    case 7%��λͼ
       I=imresize(M,[1000,1000]);%����ͼƬ��С
       I=im2double(I);%��ͼ������ݸ�ʽת��Ϊdouble�͵ģ���ʱͼ�����ֵ��Χ��ԭ����[0,255]�������[0,1]
       F=fft2(I);%���и���Ҷ�任
       F=fftshift(F);%�Ը���Ҷ�任���ͼ���������ת��
       FA=angle(F);%��ģ
       imshow(FA*180/pi);%������ס�����Ҷ�任�����ֵ��Χ�ǳ���Ϊ�˽�����ֵ��ȣ�ʹ��log������FM+1��Ϊ�˱�֤������Ϊ������
       set(handles.axes1);
       
    case 8%��ֵͼ
       I=imresize(M,[1000,1000]);%����ͼƬ��С
       I=im2double(I);%��ͼ������ݸ�ʽת��Ϊdouble�͵ģ���ʱͼ�����ֵ��Χ��ԭ����[0,255]�������[0,1]
       F=fft2(I);%���и���Ҷ�任
       F=fftshift(F);%�Ը���Ҷ�任���ͼ���������ת��
       FM=abs(F);%��ģ
       imshow(log(FM+1),[]);%������ס�����Ҷ�任�����ֵ��Χ�ǳ���Ϊ�˽�����ֵ��ȣ�ʹ��log������FM+1��Ϊ�˱�֤������Ϊ������
       set(handles.axes1);
end
