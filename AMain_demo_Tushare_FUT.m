%% AMain_demo_Tushare_FUT
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
% 输入您自己的Token,查看位置https://tushare.pro/user/token

YourTushareToken_char = TushareToken;
token = YourTushareToken_char;
api = pro_api(token);

%% 期货合约信息表
tic;
tData = api.query('fut_basic','exchange','DCE');
tData(1:gPara.len_demo,:)
toc;
%% 交易日历
tic;
tData = api.query('trade_cal','exchange','DCE');
tData(1:gPara.len_demo,:)
toc;
%% 期货日线行情
tic;
tData = api.query('fut_daily','ts_code','CU1811.SHF');
tData(1:gPara.len_demo,:)
toc;
%% 每日成交持仓排名
tic;
tData = api.query('fut_holding','symbol','C','exchange','DCE','trade_date','20181113');
tData(1:gPara.len_demo,:)
toc;
%% 仓单日报
tic;
tData = api.query('fut_wsr','symbol','ZN','trade_date','20181113');
tData(1:gPara.len_demo,:)
toc;
%% 结算参数
tic;
tData = api.query('fut_settle','symbol','DCE','trade_date','20181113');
tData(1:gPara.len_demo,:)
toc;
%% ETC
over = 1;

%% Record Time
toc;
displayEndOfDemoMessage(mfilename);
