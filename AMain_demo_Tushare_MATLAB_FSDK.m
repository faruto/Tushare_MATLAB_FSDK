%% AMain_demo_Tushare_MATLAB_FSDK
% by LiYang_faruto
% Email:farutoliyang@foxmail.com
% 2018/12/01
%% A Little Clean Work
tic;
% clear;
% clc;
% close all;
format compact;
%% tushare api connect

token = 'YourTushareToken';
api = pro_api(token);

%% stock_basic

stock_basic = api.query('stock_basic');

%% daily_basic

daily_basic = api.query('daily_basic','ts_code','','trade_date','20181106');

%% suspend

suspend = api.query('suspend','ts_code','600848.SH','fields', ...
    'ts_code,ann_date');

%% trade_cal

trade_cal = api.query('trade_cal','exchange','SZSE', ...
    'start_date','20070101','end_date','20190101');

%% stock_company

stock_company = api.query('stock_company');

%% hs_const

hs_const = api.query('hs_const','hs_type','SH');

%% fund_basic

fund_basic = api.query('fund_basic');

%% bo_cinema

bo_cinema = api.query('bo_cinema','date','20181105');

%% fut_basic

fut_basic = api.query('fut_basic','exchange','DCE');

%% trade_cal

trade_cal = api.query('trade_cal','exchange','DCE');

%% fut_daily

fut_daily = api.query('fut_daily','ts_code','CU1811.SHF');
%% fut_holding

fut_holding = api.query('fut_holding','symbol','C','exchange','DCE','trade_date','20181113');
%% fut_settle

fut_settle = api.query('fut_settle','symbol','DCE','trade_date','20181113');

%% 新闻资讯 news 用户积累1500积分可以调取，超过5000无限制

news = api.query('news','start_date','20181121','end_date','20181122','src','wallstreetcn');

%% ETC
over = 1;

%% Record Time
toc;
displayEndOfDemoMessage(mfilename);
