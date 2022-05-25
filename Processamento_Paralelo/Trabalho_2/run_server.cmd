@echo off

setlocal
    echo Running server....

    cd rmi_server
    call mvn exec:java

    echo Done!
endlocal