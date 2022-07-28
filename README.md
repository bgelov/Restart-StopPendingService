# Restart-StopPendingService
Script for restarting a service that constantly hangs in StopPending status. Restart-StopPendingService script works using PSExec, since there are not always enough rights to terminate the process via the standard taskkill.

Download PSExec: https://docs.microsoft.com/en-us/sysinternals/downloads/psexec


Parameters: Directory with psexec64.exe, Service name, Process name
