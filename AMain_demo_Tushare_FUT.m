%% AMain_demo_Tushare_FUT
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
% 输入您自己的Token,查看位置https://tushare.pro/user/token

YourTushareToken_char = TushareToken;
token = YourTushareToken_char;
api = pro_api(token);

%% 期货合约信息表

tData = api.query('fut_basic','exchange','DCE');
tData(1:gPara.len_demo,:)
%% 交易日历

tData = api.query('trade_cal','exchange','DCE');
tData(1:gPara.len_demo,:)
%% 期货日线行情

tData = api.query('fut_daily','ts_code','CU1811.SHF');
tData(1:gPara.len_demo,:)
%% 每日成交持仓排名

tData = api.query('fut_holding','symbol','C','exchange','DCE','trade_date','20181113');
tData(1:gPara.len_demo,:)
%% 仓单日报

tData = api.query('fut_wsr','symbol','ZN','trade_date','20181113');
tData(1:gPara.len_demo,:)
%% 结算参数

tData = api.query('fut_settle','symbol','DCE','trade_date','20181113');
tData(1:gPara.len_demo,:)

%% ETC
over = 1;

%% Record Time
toc;
displayEndOfDemoMessage(mfilename);
