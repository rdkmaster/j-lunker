@echo off

cd nginx-1.11.9
nginx.exe -s quit

echo "Web server is stopped, please close 'J-lunker console' window manually."
pause