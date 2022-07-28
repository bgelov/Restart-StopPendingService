# Restart-StopPendingService
Script for restart services in StopPending state with PSExec


Download PSExec: https://docs.microsoft.com/en-us/sysinternals/downloads/psexec


Parameters:
#Directory with psexec64.exe
$PSexecDir = 'C:\PSExec\'
#Service name
$ServiceName = "MyService Name"
#Process name
$ProcessName = "Myservice"
