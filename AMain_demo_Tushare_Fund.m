%% AMain_demo_Tushare_Fund
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

%% 公募基金列表
tic;
tData = api.query('fund_basic','market','E');
tData(1:gPara.len_demo,:)
toc;
%% 公募基金公司
tic;
tData = api.query('fund_company');
tData(1:gPara.len_demo,:)
toc;
%% 公募基金净值
tic;
tData = api.query('fund_nav','ts_code','165509.SZ');
tData(1:gPara.len_demo,:)
toc;
%% 公募基金分红
tic;
tData = api.query('fund_div','ann_date','20181018');
tData(1:gPara.len_demo,:)
toc;
%% 公募基金持仓数据
tic;
tData = api.query('fund_portfolio','ts_code','001753.OF');
tData(1:gPara.len_demo,:)
toc;
%% 场内基金日线行情
tic;
tData = api.query('fund_daily','ts_code','510050.SH','start_date','20180101','end_date','20181201');
tData(1:gPara.len_demo,:)
toc;
%% ETC
over = 1;

%% Record Time
toc;
displayEndOfDemoMessage(mfilename);
