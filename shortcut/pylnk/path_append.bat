@echo off
:: ����Ҫ���ü��뵽path���������е�·��
:: ��Ҫ����ԱȨ��
:: set My_PATH=C:\BaiduSyncdisk\shortcut
set My_PATH=%1
 
set PATH=%PATH%;%My_PATH%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "Path" /t REG_EXPAND_SZ /d "%PATH%" /f
:: ͨ��Dos���ڴ�ӡҪ�޸ĵĻ���������ˢ�»����������Ӷ�ʹ���̻���������Ч���Ͳ���Ҫ�����ˡ�
echo %PATH% 
exit