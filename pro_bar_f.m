function data = pro_bar_f(ts_code,api,start_date,end_date,freq,asset, ...
    exchange,adj,ma,factors,contract_type,retry_count)
% by LiYang_faruto
% Email:farutoliyang@foxmail.com
% 2019/05/01
% ����˵����
%{
tushare python���� data_por����pro_bar��MATLAB��ֲʵ��
������python�汾�������ܱ���һ��
    Parameters:
    ------------
    ts_code:֤ȯ���룬֧�ֹ�Ʊ,ETF/LOF,�ڻ�/��Ȩ,�۹�,���ֻ���
    start_date:��ʼ����  YYYYMMDD
    end_date:�������� YYYYMMDD
    freq:֧��1/5/15/30/60����,��/��/��/��
    asset:֤ȯ���� E:��Ʊ�ͽ���������I:����ָ��,C:���ֻ���,FT:�ڻ� FD:����/O��Ȩ/H�۹�/�и�����/��ָ֤��/����ָ��
    exchange:�г����룬�û����ֻ�������
    adj:��Ȩ����,None����Ȩ,qfq:ǰ��Ȩ,hfq:��Ȩ
    ma:����,֧���Զ������Ƶ�ȣ��磺ma5/ma10/ma20/ma60/maN
    factors�������ݣ�Ŀǰ֧���������֣�
        vr:����,Ĭ�ϲ����أ�������ָ����factor=['vr']
        tor:�����ʣ�Ĭ�ϲ����أ�������ָ����factor=['tor']
                    �������ֶ���Ҫ��factor=['vr', 'tor']
    retry_count:�������Դ���
%}
%{
���Դ���
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
%% �����������
data = [];
if ~exist('api','var') || isempty(api)
    str = 'pro_apiδ����,����!';
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
%% ��������
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
            str = ['�����쳣������Ӧ������������ ', ...
                err.stack(i).name, ' ���� ',num2str(err.stack(i).line)];
            disp(str);
        end
    end
    
    %% ETC
    over = 1;
end

%% �Ӻ���
