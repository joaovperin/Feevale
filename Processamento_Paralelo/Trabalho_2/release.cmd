@echo off

setlocal

    set RELEASE_PATH=dist

    echo Creating release...
    rmdir /S /Q %RELEASE_PATH%
    mkdir %RELEASE_PATH%

rem Iterate though projects  and run mvnw clean install
    for %%a in (rmi_commons rmi_server rmi_client) do (
        if exist "%%a\pom.xml" (
            echo Building %%a ...
            call mvn -f %%a\pom.xml clean package -DskipTests
            if "%ERRORLEVEL%"=="0" (
                copy /Y "%%a\target\*.jar" "%RELEASE_PATH%\"
            )
        )
    )

    echo "%JAVA_HOME%\bin\java" -jar rmi_server.jar >> %RELEASE_PATH%\rmi_server.bat
    echo "%JAVA_HOME%\bin\java" -jar rmi_client.jar >> %RELEASE_PATH%\rmi_client.bat

    echo Done!
endlocal