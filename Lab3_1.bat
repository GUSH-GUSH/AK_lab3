@echo off
chcp 65001

mkdir "C:\Лабораторні\ПЗ-22-1\Гужва Артем Андрійович\batch"
CD "C:\Лабораторні\ПЗ-22-1\Гужва Артем Андрійович\batch"
mkdir "Прихована папка"
mkdir "Не прихована папка"
ATTRIB +H "Прихована папка"
xcopy /?
xcopy /? > "Не прихована папка"\copyhelp.txt
echo f | xcopy "Не прихована папка"\copyhelp.txt "Прихована папка"\copied_copyhelp.txt /Y /F
pause