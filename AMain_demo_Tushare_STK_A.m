%% AMain_demo_Tushare_STK_A
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

%% 基础数据
%{
股票列表
各交易所交易日历
沪深股通成份股
股票曾用名
上市公司基本信息
IPO新股列表
%}
%% 股票列表
tic;
tData = api.query('stock_basic','list_status','L');
tData(1:gPara.len_demo,:)
toc;
%% 交易日历
tic;
tData = api.query('trade_cal','start_date','20180101', 'end_date','20181231');
tData(1:gPara.len_demo,:)
toc;
%% 行情数据
%{
日线行情
周线行情
月线行情
复权行情
复权因子
停复牌信息
每日行情指标
通用行情接口
%}
%% 日线行情
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
