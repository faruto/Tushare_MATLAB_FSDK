%% AMain_demo_Tushare_Index
% by LiYang_faruto
% 
% Email:farutoliyang@foxmail.com
% 
% 2019/01/01
% 
% ͨ��Tushare Pro��ȡ����������ʹ�� Tushare_MATLAB_FSDK��
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

%% ָ��������Ϣ
tic;
tData = api.query('index_basic','market','SW');
tData(1:gPara.len_demo,:)
toc;
%% ָ����������
tic;
tData = api.query('index_daily','ts_code','399300.SZ','start_date','20180201','end_date','20181010');
tData(1:gPara.len_demo,:)
toc;
%% ָ���ɷֺ�Ȩ��
tic;
tData = api.query('index_weight','index_code','399300.SZ','start_date','20180901','end_date','20181010');
tData(1:gPara.len_demo,:)
toc;
%% ����ָ��ÿ��ָ��
tic;
tData = api.query('index_dailybasic','trade_date','20181018','fields','ts_code,trade_date,turnover_rate,pe');
tData(1:gPara.len_demo,:)
toc;
%% ETC
over = 1;

%% Record Time
toc;
displayEndOfDemoMessage(mfilename);
