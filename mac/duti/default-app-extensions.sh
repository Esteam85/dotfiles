#!/bin/bash
duti -s com.microsoft.VSCode yaml all
duti -s com.microsoft.VSCode txt all
duti -s com.microsoft.VSCode csv all
duti -s com.microsoft.VSCode md all
duti -s com.microsoft.VSCode json all
duti -s com.microsoft.VSCode py all

# LibreOffice — Writer (text documents)
duti -s org.libreoffice.script odt all
duti -s org.libreoffice.script ott all
duti -s org.libreoffice.script odm all
duti -s org.libreoffice.script otm all
duti -s org.libreoffice.script fodt all
duti -s org.libreoffice.script docx all
duti -s org.libreoffice.script docm all
duti -s org.libreoffice.script dotx all
duti -s org.libreoffice.script dotm all
duti -s org.libreoffice.script rtf all
duti -s org.libreoffice.script wpd all
duti -s org.libreoffice.script wps all
duti -s org.libreoffice.script wri all

# LibreOffice — Calc (spreadsheets)
duti -s org.libreoffice.script ods all
duti -s org.libreoffice.script ots all
duti -s org.libreoffice.script fods all
duti -s org.libreoffice.script xls all
duti -s org.libreoffice.script xlt all
duti -s org.libreoffice.script xlsx all
duti -s org.libreoffice.script xlsm all
duti -s org.libreoffice.script xlsb all
duti -s org.libreoffice.script xltx all
duti -s org.libreoffice.script xltm all
duti -s org.libreoffice.script dif all
duti -s org.libreoffice.script slk all
duti -s org.libreoffice.script dbf all

# Keynote (presentations)
duti -s com.apple.iWork.Keynote key all
duti -s com.apple.iWork.Keynote odp all
duti -s com.apple.iWork.Keynote otp all
duti -s com.apple.iWork.Keynote fodp all
duti -s com.apple.iWork.Keynote pptx all
duti -s com.apple.iWork.Keynote pptm all
duti -s com.apple.iWork.Keynote potx all
duti -s com.apple.iWork.Keynote potm all

# LibreOffice — Draw (diagrams & graphics)
duti -s org.libreoffice.script odg all
duti -s org.libreoffice.script otg all
duti -s org.libreoffice.script fodg all
duti -s org.libreoffice.script vsd all
duti -s org.libreoffice.script vsdx all
duti -s org.libreoffice.script vsdm all
duti -s org.libreoffice.script dxf all
duti -s org.libreoffice.script emf all
duti -s org.libreoffice.script wmf all

# LibreOffice — Math & Base
duti -s org.libreoffice.script odf all
duti -s org.libreoffice.script odb all
duti -s org.libreoffice.script odc all

# LibreOffice — Extensions & other
duti -s org.libreoffice.script oxt all
duti -s org.libreoffice.script pub all
duti -s org.libreoffice.script hwp all