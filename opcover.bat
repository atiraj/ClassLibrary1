REM Create a 'GeneratedReports' folder if it does not exist
if not exist "%~dp0GeneratedReports" mkdir "%~dp0GeneratedReports"
 
REM Remove any previous test execution files to prevent issues overwriting
IF EXIST "%~dp0NugetTestMS.trx" del "%~dp0NugetTestMS.trx%" 
REM Remove any previously created test output directories
CD %~dp0
FOR /D /R %%X IN (%USERNAME%*) DO RD /S /Q "%%X"
 
REM Run the tests against the targeted output
call :RunOpenCoverUnitTestMetrics
 
REM Generate the report output based on the test results
if %errorlevel% equ 0 (
 call :RunReportGeneratorOutput
)
 
REM Launch the report
if %errorlevel% equ 0 (
 call :OpenCoverToCoberturaConverter
)
exit /b %errorlevel%
 
:RunOpenCoverUnitTestMetrics
"%~dp0packages\OpenCover.4.6.519\tools\OpenCover.Console.exe" ^
-register:[Path32] ^
-target:"C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\mstest.exe" -filter:"[NugetTestMS.dll]" ^
-targetargs:"/testcontainer:\"%~dp0NugetTestMS\bin\Release\NugetTestMS.dll\" /resultsfile:\"%~dp0NugetTestMS.trx\"" ^
-output:"%~dp0NugetTestReport.xml" 
exit /b %errorlevel%
 
:RunReportGeneratorOutput
"%~dp0packages\ReportGenerator.2.4.5.0\tools\ReportGenerator.exe" ^
-reports:"%~dp0NugetTestReport.xml" ^
-targetdir:"%~dp0GeneratedReports\ReportGenerator Output"
exit /b %errorlevel%
 
:OpenCoverToCoberturaConverter
"%~dp0packages\OpenCoverToCoberturaConverter.0.2.4.0\tools\OpenCoverToCoberturaConverter.0.2.4.0.exe -input:"%~dp0NugetTestReport.xml" -output:"%~dp0cob.xml"

:RunLaunchReport
start "report" "%~dp0\GeneratedReports\ReportGenerator Output\index.htm"
exit /b %errorlevel%
