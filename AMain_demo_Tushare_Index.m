%% AMain_demo_Tushare_Index
% by LiYang_faruto
% 
% Email:farutoliyang@foxmail.com
% 
% 2019/01/01
% 
% 通过Tushare Pro获取数据样例（使用 Tushare_MATLAB_FSDK）
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

%% 指数基本信息
tic;
tData = api.query('index_basic','market','SW');
tData(1:gPara.len_demo,:)
toc;
%% 指数日线行情
tic;
tData = api.query('index_daily','ts_code','399300.SZ','start_date','20180201','end_date','20181010');
tData(1:gPara.len_demo,:)
toc;
%% 指数成分和权重
tic;
tData = api.query('index_weight','index_code','399300.SZ','start_date','20180901','end_date','20181010');
tData(1:gPara.len_demo,:)
toc;
%% 大盘指数每日指标
tic;
tData = api.query('index_dailybasic','trade_date','20181018','fields','ts_code,trade_date,turnover_rate,pe');
tData(1:gPara.len_demo,:)
toc;
%% ETC
over = 1;

%% Record Time
toc;
displayEndOfDemoMessage(mfilename);
