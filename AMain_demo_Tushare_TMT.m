%% AMain_demo_Tushare_TMT
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

%% 电影月度票房
tic;
tData = api.query('bo_monthly','date','20181101');
tData(1:gPara.len_demo,:)
toc;
%% 电影周度票房
tic;
tData = api.query('bo_weekly','date','20181126');
tData(1:gPara.len_demo,:)
toc;
%% 电影日度票房
tic;
tData = api.query('bo_daily','date','20181207');
tData(1:gPara.len_demo,:)
toc;
%% 影院每日票房
tic;
tData = api.query('bo_cinema','date','20181207');
tData(1:gPara.len_demo,:)
toc;
%% ETC
over = 1;

%% Record Time
toc;
displayEndOfDemoMessage(mfilename);
