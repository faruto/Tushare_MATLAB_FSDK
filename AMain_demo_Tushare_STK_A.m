%% AMain_demo_Tushare_STK_A
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

%% ��������
%{
��Ʊ�б�
����������������
�����ͨ�ɷݹ�
��Ʊ������
���й�˾������Ϣ
IPO�¹��б�
%}
%% ��Ʊ�б�
tic;
tData = api.query('stock_basic','list_status','L');
tData(1:gPara.len_demo,:)
toc;
%% ��������
tic;
tData = api.query('trade_cal','start_date','20180101', 'end_date','20181231');
tData(1:gPara.len_demo,:)
toc;
%% ��������
%{
��������
��������
��������
��Ȩ����
��Ȩ����
ͣ������Ϣ
ÿ������ָ��
ͨ������ӿ�
%}
%% ��������
tic;
tData = api.query('daily','ts_code','000001.SZ','start_date','20180101','end_date','20181231');
tData(1:gPara.len_demo,:)
toc;

%%

%% ETC
over = 1;

%% Record Time
toc;
displayEndOfDemoMessage(mfilename);
