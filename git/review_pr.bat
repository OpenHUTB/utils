@echo off
:: ʹ��ʾ����review_pr.bat 14
:: �ο���https://docs.github.com/zh/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/checking-out-pull-requests-locally

:: ��0������Ϊ�ļ���
echo param[0] = %0
:: ��1������Ϊpull request�ı��
echo param[1] = %1

:: ������ ID �Ż�ȡ�Ը���ȡ��������ã��ڸù����д���һ���·�֧��
git fetch origin pull/%1/head:%1

:: �л������ڴ���ȡ������·�֧��
git checkout %1
:: git checkout -f 14


echo ...
pause