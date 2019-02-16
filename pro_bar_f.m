function data = pro_bar_f(ts_code,api,start_date,end_date,freq,asset, ...
    exchange,adj,ma,factors,contract_type,retry_count)
% by LiYang_faruto
% Email:farutoliyang@foxmail.com
% 2019/05/01
% 函数说明：
%{
tushare python包中 data_por函数pro_bar的MATLAB移植实现
尽量与python版本函数功能保持一致
    Parameters:
    ------------
    ts_code:证券代码，支持股票,ETF/LOF,期货/期权,港股,数字货币
    start_date:开始日期  YYYYMMDD
    end_date:结束日期 YYYYMMDD
    freq:支持1/5/15/30/60分钟,周/月/季/年
    asset:证券类型 E:股票和交易所基金，I:沪深指数,C:数字货币,FT:期货 FD:基金/O期权/H港股/中概美国/中证指数/国际指数
    exchange:市场代码，用户数字货币行情
    adj:复权类型,None不复权,qfq:前复权,hfq:后复权
    ma:均线,支持自定义均线频度，如：ma5/ma10/ma20/ma60/maN
    factors因子数据，目前支持以下两种：
        vr:量比,默认不返回，返回需指定：factor=['vr']
        tor:换手率，默认不返回，返回需指定：factor=['tor']
                    以上两种都需要：factor=['vr', 'tor']
    retry_count:网络重试次数
%}
%{
测试代码
ts_code = '000001.SZ';
start_date = '20190101';
end_date = '20190215';
freq = '15min';
asset = 'E';
exchange = '';
adj = 'qfq';
ma = [];
factors = [];
contract_type = '';
retry_count = 3;
data = pro_bar_f(ts_code,api,start_date,end_date,freq,asset, ...
    exchange,adj,ma,factors,contract_type,retry_count);
%}
%% 输入输出处理
data = [];
if ~exist('api','var') || isempty(api)
    str = 'pro_api未输入,请检查!';
    disp(str)
  
    return;
    
    YourTushareToken_char = TushareToken;
    token = YourTushareToken_char;
    api = pro_api(token);

end
if ~exist('ts_code','var') || isempty(ts_code)
    ts_code = '000001.SZ';
end
if ~exist('start_date','var') || isempty(start_date)
    start_date = '20190101';
end
if ~exist('end_date','var') || isempty(end_date)
    end_date = '';
end
if ~exist('freq','var') || isempty(freq)
    freq = 'D';
end
if ~exist('asset','var') || isempty(asset)
    asset = 'E';
end
if ~exist('exchange','var') || isempty(exchange)
    exchange = '';
end
if ~exist('adj','var') || isempty(adj)
    adj = 'qfq';
    %adj = '';
end
if ~exist('ma','var') || isempty(ma)
    ma = [];
end
if ~exist('factors','var') || isempty(factors)
    factors = [];
end
if ~exist('contract_type','var') || isempty(contract_type)
    contract_type = '';
end
if ~exist('retry_count','var') || isempty(retry_count)
    retry_count = 3;
end
%% 基础数据
ts_code = upper(deblank(ts_code));

PRICE_COLS = {'open','high','low','close','pre_close'};

%% Main

for tr = 1:retry_count
    try
        freq = upper(deblank(freq));
        asset = upper(deblank(asset));
        if strcmpi(asset,'E')
            if strcmpi(freq,'D')
                df = api.query('daily', 'ts_code', ts_code, 'start_date', start_date, 'end_date', end_date);
            end
            if strcmpi(freq,'W')
                df = api.query('weekly', 'ts_code', ts_code, 'start_date', start_date, 'end_date', end_date);
            end
            if strcmpi(freq,'M')
                df = api.query('monthly', 'ts_code', ts_code, 'start_date', start_date, 'end_date', end_date);
            end            
            if length(freq)>3 && strcmpi(freq(end-2:end),'MIN')
                df = api.query('mins', 'ts_code', ts_code, 'start_time', start_date, 'end_time', end_date, ...
                    'freq',lower(freq));
                tFun = @(x)( datestr( datenum(x,'yyyy-mm-dd HH:MM:SS'),'yyyymmdd' ) );
                df.trade_date = cellfun(tFun,df.trade_time,'Uniformoutput',false);
                df.pre_close = [nan;df.close(1:end-1)];
            end
            
            if ~isempty(adj)
                fcts = api.query('adj_factor','ts_code',ts_code,'start_date',start_date,'end_date',end_date);
                data = outerjoin(df,fcts,'Type','left', 'MergeKeys',true);
                data = fillmissing(data, 'previous');
                
                tList = intersect(PRICE_COLS,data.Properties.VariableNames);
                for i = 1:length(tList)
                    tF = tList{i};
                    if strcmpi(adj,'hfq')
                        data.(tF) = data.(tF).*data.adj_factor;
                    else
                        data.(tF) = data.(tF).*data.adj_factor./data.adj_factor(end);
                    end
                end
                
            else
                data = df;
            end
        end
        
    catch err
        disp(err.message)
        tLen = size(err.stack);
        for i = 1:tLen
            str = ['出现异常请检查相应函数：函数名 ', ...
                err.stack(i).name, ' 行数 ',num2str(err.stack(i).line)];
            disp(str);
        end
    end
    
    %% ETC
    over = 1;
end

%% 子函数
