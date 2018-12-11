function oData = Unicode2Chinese(iData)
% by LiYang_faruto
% Email:farutoliyang@foxmail.com
% 2018/12/01
% ����˵������\u��ͷ��unicodeת����
% ���A '\u4e07\u79d1A'
%% �����������
oData = [];

demo_onoff = 0;
if 1 == demo_onoff
    iData = '\u5e73\u5b89\u94f6\u884c';
    iData = '\u6df1\u5733';
    % ���A
    iData = '\u4e07\u79d1A';
    iData = '��\u79d1A';
    iData = '\uff1a';
    % *ST\u5730\u77ff
    % ST *ST�Ĵ���
    iData = '*ST\u5730\u77ff';
    % 2\u4eba/\u5428 2�����Ԫ/��
    iData = '2\u4eba/\u5428';
    % 0.05\u4eba\u6c11\u5e01\u5143/\u5f20
    iData = '0.05\u4eba\u6c110.05\u5e01\u5143/\u5f20';
end

%% Main
x = iData;

expr = '\\u';
tData = regexpi(x,expr,'split');
tData1 = tData(1);

tFun = @Unicode2Chinese_F;
y = cellfun( tFun,tData(2:end),'UniformOutput',false);
y = [tData1,y];
if isempty(y{1,1})
    y = y(2:end);
end
y = cell2mat(y);

oData = y;

end

function y = Unicode2Chinese_F(x)
y = x;
if isempty(x)
    y = [];
    return;
end
% ������ĳЩ�����ַ�ֱ�ӷ���
if sum(isChineseChar(x))
    return;
end

try
    x_copy = x;
    x = x(1:4);
    y = reshape(x',2,2)';
    
    temp = hex2dec(y);
    y = native2unicode(uint8(temp'),'UTF-16BE');
    y = [y,x_copy(5:end)];
catch
    return;
end

end