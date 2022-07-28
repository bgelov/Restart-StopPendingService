#Script for restart services in StopPending state with PSExec

#Directory with psexec64.exe
$PSexecDir = 'C:\PSExec\'
#Service name
$ServiceName = "MyService Name"
#Process name
$ProcessName = "Myservice"


    if ((Get-Service $ServiceName | select status -ExpandProperty status) -eq 'Running') {
        Write-Host 'Stopping service...' -ForegroundColor Yellow
        Stop-Service $ServiceName -Force -NoWait
        #Wait progress
        [int]$timer = 30
        for ($i = 1; $i -le $timer; $i++) {
            Write-Progress -Activity "Stopping service $ServiceName. Wait $timer seconds" -Status "Sec.: $i" -PercentComplete ($i/$timer*100)
            Start-Sleep -Seconds 1
        }
    }

    $ServiceStatus = $null
    $ServiceStatus = Get-Service $ServiceName | select status -ExpandProperty status
    Write-Host "$ServiceName service in $ServiceStatus status"

    if ($ServiceStatus -eq 'StopPending') { 
        $process_id = $null
        $process_id = get-process $ProcessName | select id -ExpandProperty id
        if ($process_id) {
            Write-Host "$ProcessName process ID: $process_id" -ForegroundColor Yellow
            Write-Host "Start terminate $ProcessName process..." -ForegroundColor Yellow
            $arguments = "-s -accepteula taskkill /pid $process_id /F"
            Start-Process psexec64.exe -WorkingDirectory $PSexecDir -ArgumentList $arguments -Verb runAs

        } #process
     } #StopPending

    #Wait progress
    [int]$timer = 30
    for ($i = 1; $i -le $timer; $i++) {
        Write-Progress -Activity "Stopping $ProcessName process. Wait $timer seconds" -Status "Sec.: $i" -PercentComplete ($i/$timer*100)
        Start-Sleep -Seconds 1
    }

    $ServiceStatus = Get-Service $ServiceName | select status -ExpandProperty status
    Write-Host "$ServiceName service in $ServiceStatus status"

    if ($ServiceStatus -eq 'Stopped') {
        Write-Host "$ServiceName service successfully stopped!" -ForegroundColor Green

        Write-Host "Starting $ServiceName service..." -ForegroundColor Yellow
        Start-Service $ServiceName


    } else {  
        Write-Host "$ServiceName service in $ServiceStatus status" -ForegroundColor Yellow
    }

    $process_id = $null
    $process_id = get-process $ProcessName -ea SilentlyContinue | select id -ExpandProperty id
    if ($process_id) {
        Write-Host "$ProcessName process does not stop! Process id: $process_id" -ForegroundColor Red
    }
