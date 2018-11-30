function data = pro_bar(ts_code, pro_api, start_date, end_date, freq, asset, market, adj, ma, factors, retry_count)
%---------------------------------------
% Tushare pro_bar Matlab Interface
% Author(s) - Lianrui Fu (fulrbuaa#163{dot}com)
% Affiliation - National Laboratory of Pattern Recognition, Institute of Automation, Chinese Academy of Sciences
% Update Date - 2018-10-31
%---------------------------------------
% BAR���ݵ���˵���� 
% data = pro_bar(ts_code, pro_api, start_date, end_date, freq, asset, market, adj, ma, factors, retry_count)
% ������ ��������4��
%     ts_code:֤ȯ���룬֧�ֹ�Ʊ,ETF/LOF,�ڻ�/��Ȩ,�۹�,���ֻ���,��'000001.SZ','000905.SH'
%     start_date:��ʼ����  YYYYMMDD, ��'20181001'
%     end_date:�������� YYYYMMDD,''��ʾ��ǰ����
%     freq:֧��1/5/15/30/60����,��/��/��/��, ��'D'
%     asset:֤ȯ���� E:��Ʊ�ͽ���������I:����ָ��,C:���ֻ���,F:�ڻ�/��Ȩ/�۹�/�и�����/��ָ֤��/����ָ��,��'E'
%     market:�г�����,Ĭ��''
%     adj:��Ȩ����,''����Ȩ,'qfq':ǰ��Ȩ,'hfq':��Ȩ
%     ma:����,֧���Զ������Ƶ�ȣ��磺ma5/ma10/ma20/ma60/maN,��[],5,[5,10],[5,10,20],��n��MAֵ������ͻ���Ӧ׷���У�����N��ľ���ֵ��NaN���
%     factors�������ݣ�Ŀǰ֧���������֣�
%         vr:����,Ĭ�ϲ����أ�������ָ����factor=['vr']
%         tor:�����ʣ�Ĭ�ϲ����أ�������ָ����factor=['tor']
%                     �������ֶ���Ҫ��factor=['vr', 'tor']
%     retry_count:�������Դ�����Ĭ��3
% �����
%     dataΪmatalb table�������ͣ���pandas��DataFrame�ǳ��ӽ�
%     ����ʧ��ʱ������ʾ��Ӧԭ�򣬳���ԭ��(1)token��Ч��(2)���粻������(3)Matlab�汾���ͣ���2016b������
% ����ʾ��
% token = 'c7b68d2a726dc747e6d6c4484a42b9275b7d8389a****************';
% api = pro_api(token);
% dd1 = pro_bar('000001.SZ', api, '19990101', '20181031');
% dd2 = pro_bar('000001.SZ', api, '19990101', '');
% dd_ma1 = pro_bar('000001.SZ', api, '19990101', '', 'D', 'E', '', 'qfq', [5]);
% dd_ma3 = pro_bar('000001.SZ', api, '19990101', '', 'D', 'E', '', 'qfq', [5, 10, 20]);
% dd_index = pro_bar('000905.SH', api, '19990101', '', 'D', 'I');
% disp(dd_ma3(1:10,:));
% >>
%       ts_code      trade_date    open     high      low     close    pre_close    change    pct_change       vol          amount       ma5     ma10     ma20 
%     ___________    __________    _____    _____    _____    _____    _________    ______    __________    __________    __________    _____    _____    _____
% 
%     '000001.SZ'    '20181030'    10.78    11.08    10.73     10.9    10.75         0.15      1.3953       1.5018e+06    1.6414e+06    11.03    10.83    10.65
%     '000001.SZ'    '20181029'     11.2    11.24    10.62    10.75    11.18        -0.43     -3.8462       1.5916e+06    1.7259e+06    11.02    10.78    10.63
%     '000001.SZ'    '20181026'    11.29    11.31    10.96    11.18    11.29        -0.11     -0.9743          1.3e+06    1.4488e+06     11.1    10.72    10.63
%     '000001.SZ'    '20181025'     10.8    11.29    10.71    11.29    11.04         0.25      2.2645        1.685e+06    1.8558e+06    11.02    10.63    10.58
%     '000001.SZ'    '20181024'     10.9    11.33     10.8    11.04    10.84          0.2       1.845       1.8294e+06    2.0262e+06    10.78    10.49    10.53
%     '000001.SZ'    '20181023'     11.2    11.22    10.73    10.84    11.15        -0.31     -2.7803       1.6025e+06    1.7593e+06    10.63    10.43    10.48
%     '000001.SZ'    '20181022'    10.81    11.46    10.78    11.15    10.76         0.39      3.6245       2.6455e+06    2.9327e+06    10.54     10.4    10.42
%     '000001.SZ'    '20181019'     9.95    10.78     9.92    10.76    10.09         0.67      6.6402       2.0837e+06    2.1736e+06    10.33    10.33    10.35
%     '000001.SZ'    '20181018'    10.29    10.29    10.06    10.09    10.33        -0.24     -2.3233       1.0012e+06    1.0157e+06    10.24    10.36    10.31
%     '000001.SZ'    '20181017'     10.5    10.55    10.14    10.33    10.37        -0.04     -0.3857       1.3509e+06    1.4003e+06    10.19    10.42     10.3


if nargin<11, retry_count = 3; end
if nargin<10, factor = []; end
if nargin<9, ma = []; end
if nargin<8, adj = ''; end
if nargin<7, market = ''; end
if nargin<6, asset = 'E'; end
if nargin<5, freq = 'D'; end
if nargin<4, error('�������벻������4��.'); end
data = [];
ts_code = upper(deblank(ts_code));
api = pro_api;
for tt= 1:retry_count
    try
        freq = upper(deblank(freq));
        asset = upper(deblank(asset));
        if strcmp(asset, 'E')
            if strcmp(freq, 'D')
                df = api.query('daily', 'ts_code', ts_code, 'start_date', start_date, 'end_date', end_date);
                if isempty(df), return; end
                if ~strcmp(adj, '')
                    df_fcts = api.query('adj_factor', 'ts_code', ts_code, 'start_date', start_date, 'end_date', end_date);
                    if isempty(df_fcts), return; end
                    fcts = df_fcts(:, 2:3);
                    df_mix = outerjoin(df,fcts,'Type','left', 'MergeKeys',true);
                    df_mix = sortrows(df_mix, -2);
                    dfx = fillmissing(df_mix, 'previous');
                    dfx2 = dfx;
                    for k = [3, 4, 5, 6] % open high low close
                        if strcmpi(adj, 'hfq')
                            dfx2{:,k} = dfx{:,k}.*dfx{:,12};
                        else
                            dfx2{:,k} = dfx{:,k}.*dfx{:,12} / fcts{1,end};
                        end % adj
                        dfx2{:,k} = roundn(dfx2{:,k}, -2);
                    end % k
                    data = dfx2(:,1:end-1);
                else % adj==''
                    data = df;     
                end % adj
                
                if  ~isempty(ma)
                    for aa =ma
                        if fix(aa)==aa
                            a = fix(aa);
                            % ma --------------
                            data_close = data{:,6};
                            ma_close = tsmovavg(data_close', 's', a)';
                            ma_close1 = roundn(ma_close, -2);
                            sz = length(ma_close1);
                            ma_close(1:sz-a+1) = ma_close1(a:sz); 
                            ma_close(sz-a+2: sz) = ma_close1(1:a-1);
                            ma_cell = [data{:,2}, num2cell(ma_close)];
                            df_ma = cell2table(ma_cell, 'VariableNames', {'trade_date', ['ma' num2str(a)]});
                            data = join(data, df_ma);
                        end
                    end
                end % if ma
            end % if freq
        elseif strcmp(asset, 'I')
            if freq == 'D'
                data = api.query('index_daily', 'ts_code', ts_code, 'start_date', start_date, 'end_date', end_date);
                if isempty(data), return; end
            end
        elseif  strcmp(asset, 'I')
            disp('well soon');
            % pass ------
        end % if asset
        break;
    catch
        fprintf('Failed %d times\n', tt);
    end % try
end % for retry_count
end

