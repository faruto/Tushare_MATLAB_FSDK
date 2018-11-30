function isFlag = isChineseChar(InputString,encoding)
% by LiYang_faruto
% Email:farutoliyang@foxmail.com
% 2014/12/12
%% �������Ԥ����
if nargin < 2
    encoding = 'GB2312';
end
if nargin < 1
    InputString = 'FM�ٶ�һ��Test';
end

Len = length(InputString);
isFlag = zeros(Len,1);
%% 'GB2312'
if strcmpi( encoding, 'GB2312')
    % ����GB2312���ַ���ie.��λ����һ�����ֶ�Ӧ�������ֽڡ� ÿ���ֽڶ��Ǵ���A0��ʮ������,��160����
    % ������һ���ֽڴ���A0�����ڶ����ֽ�С��A0����ô��Ӧ�����Ǻ��֣���������GB2312)
    for i = 1:Len
        info = unicode2native(InputString(i),encoding);
        bytes = size(info,2);
        Ftemp = 0;
        if (bytes == 2)
            if(info(1)>160 && info(2)>160)
                Ftemp = 1;
            end
        end
        isFlag(i) = Ftemp;
    end
end
%% 
