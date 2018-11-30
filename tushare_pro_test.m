%---------------------------------------
% Tushare Matlab Interface Samples
% Author(s) - Lianrui Fu (fulrbuaa#163{dot}com)
% Affiliation - National Laboratory of Pattern Recognition, Institute of Automation, Chinese Academy of Sciences
% Update Date - 2018-10-31
%---------------------------------------
% pro_api�ӿ�˵�� �� help pro_api
% BAR�ӿ�˵�� �� help pro_bar
% �������Ϊmatalb table�������ͣ���pandas��DataFrame�ǳ��ӽ�������ʧ��ʱ����[]
% ����ʧ��ʱ������ʾ��Ӧԭ�򣬳���ԭ��(1)token��Ч��(2)���粻������(3)Matlab�汾���ͣ���2016b������
% Tushare Matlab �ӿڵ���ʾ����

% token ��ֵ�����滻Ϊ����token
token = 'YourTushareToken';
api = pro_api(token);

% 1 tushare pro_api�ӿ�ʾ��
% results = api.query(api_name, param_name1, param_1, param_name2, param_2, ...);

% (1)��ȡstock_basic����
df_basic = api.query('stock_basic');
disp(df_basic(1:10,:));

% (2)��ȡdaily����
% �������£�
% ts_code:֤ȯ���룬֧�ֹ�Ʊ,ETF/LOF,�ڻ�/��Ȩ,�۹�,���ֻ���,��'000001.SZ','000905.SH'
% start_date:��ʼ����  YYYYMMDD, ��'20181001'
% end_date:�������� YYYYMMDD,''��ʾ��ǰ����
df_daily = api.query('daily', 'ts_code', '000001.SZ', 'start_date', '19990101', 'end_date', '');
disp(df_daily(1:10,:));

% 2 ��ȡBAR���ݣ���ϸ˵����help pro_api
% ���daily��pro_bar���Խ��и�Ȩ�����������ṩN��ƽ��ֵ
dd1 = pro_bar('000001.SZ', api, '19990101', '20181031');
dd2 = pro_bar('000001.SZ', api, '19990101', '');
dd_ma1 = pro_bar('000001.SZ', api, '19990101', '', 'D', 'E', '', 'qfq', 5);
dd_ma3 = pro_bar('000001.SZ', api, '19990101', '', 'D', 'E', '', 'qfq', [5, 10, 20]);
dd_index = pro_bar('000905.SH', api, '19990101', '', 'D', 'I');
disp(dd_ma3(1:10,:));




