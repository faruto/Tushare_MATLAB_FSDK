function oData = Unicode2Chinese(iData)
% by LiYang_faruto
% Email:farutoliyang@foxmail.com
% 2018/12/01
% 函数说明：把\u开头的unicode转中文
% 万科A '\u4e07\u79d1A'
%% 输入输出处理
oData = [];

demo_onoff = 0;
if 1 == demo_onoff
    iData = '\u5e73\u5b89\u94f6\u884c';
    iData = '\u6df1\u5733';
    % 万科A
    iData = '\u4e07\u79d1A';
    iData = '万\u79d1A';
    iData = '\uff1a';
end

%% Main
x = iData;

expr = '\\u';
tData = regexpi(x,expr,'split');

tFun = @Unicode2Chinese_F;
y = cellfun( tFun,tData,'UniformOutput',false);
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
if isChineseChar(x)
    return;
end

x_copy = x;
x = x(1:4);
y = reshape(x',2,2)';

temp = hex2dec(y);
y = native2unicode(uint8(temp'),'UTF-16BE');
y = [y,x_copy(5:end)];

end