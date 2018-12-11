%% AMain_demo_Tushare_Fund
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

%% ��ļ�����б�
tic;
tData = api.query('fund_basic','market','E');
tData(1:gPara.len_demo,:)
toc;
%% ��ļ����˾
tic;
tData = api.query('fund_company');
tData(1:gPara.len_demo,:)
toc;
%% ��ļ����ֵ
tic;
tData = api.query('fund_nav','ts_code','165509.SZ');
tData(1:gPara.len_demo,:)
toc;
%% ��ļ����ֺ�
tic;
tData = api.query('fund_div','ann_date','20181018');
tData(1:gPara.len_demo,:)
toc;
%% ��ļ����ֲ�����
tic;
tData = api.query('fund_portfolio','ts_code','001753.OF');
tData(1:gPara.len_demo,:)
toc;
%% ���ڻ�����������
tic;
tData = api.query('fund_daily','ts_code','510050.SH','start_date','20180101','end_date','20181201');
tData(1:gPara.len_demo,:)
toc;
%% ETC
over = 1;

%% Record Time
toc;
displayEndOfDemoMessage(mfilename);
