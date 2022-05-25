@echo off

setlocal
    echo Looking for projects to build...

    set SHOULD_SKIP_TESTS=true
    if "%1"=="--test" set SHOULD_SKIP_TESTS=false

rem Iterate though projects  and run mvnw clean install
    for %%a in (rmi_commons rmi_server rmi_client) do (
        if exist "%%a\pom.xml" (
            echo Rebuilding %%a ...
            call mvn -f %%a\pom.xml clean install -DskipTests=%SHOULD_SKIP_TESTS%
        )
    )

    echo Done!
endlocal