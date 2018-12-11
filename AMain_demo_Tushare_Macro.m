%% AMain_demo_Tushare_Macro
% by LiYang_faruto
% 
% Email:farutoliyang@foxmail.com
% 
% 2019/01/01
% 
% 通过Tushare Pro获取期货相关数据（使用 Tushare_MATLAB_FSDK）
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
%% 全局参数

gPara.len_demo = 8;

%% tushare api connect
% 输入您自己的Token,查看位置 https://tushare.pro/user/token

YourTushareToken_char = TushareToken;
token = YourTushareToken_char;
api = pro_api(token);

%% SHIBOR利率数据
tic;
tData = api.query('shibor','start_date','20180101','end_date','20181101');
tData(1:gPara.len_demo,:)
toc;
%% SHIBOR报价数据
tic;
tData = api.query('shibor_quote','start_date','20181001','end_date','20181101');
tData(1:gPara.len_demo,:)
toc;
%% LPR贷款基础利率
tic;
tData = api.query('shibor_lpr','start_date','20181001','end_date','20181101');
tData(1:gPara.len_demo,:)
toc;
%% LIBOR拆借利率
tic;
tData = api.query('libor','curr_type','USD', 'start_date','20180101','end_date','20181130');
tData(1:gPara.len_demo,:)
toc;
%% HIBOR利率
tic;
tData = api.query('hibor','start_date','20180101','end_date','20181130');
tData(1:gPara.len_demo,:)
toc;
%% ETC
over = 1;

%% Record Time
toc;
displayEndOfDemoMessage(mfilename);
