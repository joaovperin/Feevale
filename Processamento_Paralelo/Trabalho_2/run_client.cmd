@echo off

setlocal
    echo Running client....

    cd rmi_client
    call mvn exec:java

    echo Done!
endlocal