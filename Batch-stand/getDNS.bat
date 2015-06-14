@echo off
for /f "tokens=2 delims=:" %%a in ('echo quit^|nslookup^|find "Address:"') do set DNSIP=%%a
pause


::set vardns1=Primary DNS IP Address Here
::set vardns2=Secondary DNS IP Address Here

::set googledns1=Setting Primary DNS for GoogleDNS
::set googledns2=Setting Secondary DNS for GoogleDNS
::set googledns1a=8.8.8.8
::set googledns2a=8.8.4.4

::set opendns1=Setting Primary DNS for OpenDNS
::set opendns2=Setting Secondary DNS for OpenDNS
::set opendns1a=208.67.222.222
::set opendsn2a=208.67.220.220

::set displaycurrent=Your current DNS adress is:




ECHO Setting Primary DNS
netsh int ip set dns name = "Local Area Connection" source = static addr = %vardns1%

ECHO Setting Secondary DNS
netsh int ip add dns name = "Local Area Connection" addr = %vardns2%

ipconfig /flushdns

exit


::test1
netsh interface ipv4 set dns name=%nomCarteReseau% static %dns1%
netsh interface ipv4 add dns name=%nomCarteReseau% %dns2%


:: GET your interface name
echo netsh interface show interface
echo check Interface Name: Wifi-2  Ethernet 2 
echo force choose Ethernet 2
echo disable Wifi-2
echo apply to activated interface name



::::::::::::::::::::::::::::::::::::::::
:: Change Google DNS to all activated ::
::::::::::::::::::::::::::::::::::::::::
set DNS1=8.8.8.8
set DNS2=8.8.4.4

for /f "tokens=1,2,3*" %%i in ('netsh int show interface') do (
    if %%i equ Enabled (
        echo Changing "%%l" : %DNS1% + %DNS2%
        netsh int ipv4 set dns name="%%l" static %DNS1% primary validate=no
        netsh int ipv4 add dns name="%%l" %DNS2% index=2 validate=no
    )
)

ipconfig /flushdns
:EOF
:::::::::::::::::::::::::::::::::::::::::

::ADD 
echo netsh interface ipv4 add dnsserver "Ethernet" 8.8.8.8 index=1

::SET/MODIFY
echo netsh interface ipv4 set dnsservers "Wi-Fi" static 8.8.8.8 primary
echo netsh interface ipv4 set dnsservers "Wi-Fi" static 8.8.4.4 secondary







