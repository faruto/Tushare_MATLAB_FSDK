%% AMain_demo_Tushare_FUT
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
% �������Լ���Token,�鿴λ��https://tushare.pro/user/token

YourTushareToken_char = TushareToken;
token = YourTushareToken_char;
api = pro_api(token);

%% �ڻ���Լ��Ϣ��

tData = api.query('fut_basic','exchange','DCE');
tData(1:gPara.len_demo,:)
%% ��������

tData = api.query('trade_cal','exchange','DCE');
tData(1:gPara.len_demo,:)
%% �ڻ���������

tData = api.query('fut_daily','ts_code','CU1811.SHF');
tData(1:gPara.len_demo,:)
%% ÿ�ճɽ��ֲ�����

tData = api.query('fut_holding','symbol','C','exchange','DCE','trade_date','20181113');
tData(1:gPara.len_demo,:)
%% �ֵ��ձ�

tData = api.query('fut_wsr','symbol','ZN','trade_date','20181113');
tData(1:gPara.len_demo,:)
%% �������

tData = api.query('fut_settle','symbol','DCE','trade_date','20181113');
tData(1:gPara.len_demo,:)

%% ETC
over = 1;

%% Record Time
toc;
displayEndOfDemoMessage(mfilename);
