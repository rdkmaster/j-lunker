@echo off

title J-lunker console

cd nginx-1.11.9
start nginx.exe

cd ..
"%JAVA_HOME%"\bin\java -Xms64m -Xmx256m -Dfile.encoding=UTF-8 -classpath proc/bin/lib/* com.zte.vmax.rdk.Run
