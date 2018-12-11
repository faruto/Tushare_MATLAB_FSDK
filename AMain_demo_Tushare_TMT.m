%% AMain_demo_Tushare_TMT
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

%% ��Ӱ�¶�Ʊ��
tic;
tData = api.query('bo_monthly','date','20181101');
tData(1:gPara.len_demo,:)
toc;
%% ��Ӱ�ܶ�Ʊ��
tic;
tData = api.query('bo_weekly','date','20181126');
tData(1:gPara.len_demo,:)
toc;
%% ��Ӱ�ն�Ʊ��
tic;
tData = api.query('bo_daily','date','20181207');
tData(1:gPara.len_demo,:)
toc;
%% ӰԺÿ��Ʊ��
tic;
tData = api.query('bo_cinema','date','20181207');
tData(1:gPara.len_demo,:)
toc;
%% ETC
over = 1;

%% Record Time
toc;
displayEndOfDemoMessage(mfilename);
