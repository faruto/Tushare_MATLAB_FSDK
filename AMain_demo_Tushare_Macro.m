%% AMain_demo_Tushare_Macro
% by LiYang_faruto
% 
% Email:farutoliyang@foxmail.com
% 
% 2019/01/01
% 
% ͨ��Tushare Pro��ȡ�ڻ�������ݣ�ʹ�� Tushare_MATLAB_FSDK��
% 
% Tushare_MATLAB_FSDK see 
% 
% <https://github.com/faruto/Tushare_MATLAB_FSDK Tushare_MATLAB_FSDK>
%
% <https://faruto.github.io/html/index.html faruto_github_io>
%% A Little Clean Work
tic;
% clear;
% clc;
% close all;
format compact;
%% ȫ�ֲ���

gPara.len_demo = 8;

%% tushare api connect
% �������Լ���Token,�鿴λ�� https://tushare.pro/user/token

YourTushareToken_char = TushareToken;
token = YourTushareToken_char;
api = pro_api(token);

%% SHIBOR��������
tic;
tData = api.query('shibor','start_date','20180101','end_date','20181101');
tData(1:gPara.len_demo,:)
toc;
%% SHIBOR��������
tic;
tData = api.query('shibor_quote','start_date','20181001','end_date','20181101');
tData(1:gPara.len_demo,:)
toc;
%% LPR�����������
tic;
tData = api.query('shibor_lpr','start_date','20181001','end_date','20181101');
tData(1:gPara.len_demo,:)
toc;
%% LIBOR�������
tic;
tData = api.query('libor','curr_type','USD', 'start_date','20180101','end_date','20181130');
tData(1:gPara.len_demo,:)
toc;
%% HIBOR����
tic;
tData = api.query('hibor','start_date','20180101','end_date','20181130');
tData(1:gPara.len_demo,:)
toc;
%% ETC
over = 1;

%% Record Time
toc;
displayEndOfDemoMessage(mfilename);
