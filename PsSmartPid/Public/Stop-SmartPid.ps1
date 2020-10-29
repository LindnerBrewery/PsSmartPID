function Stop-SmartPid {
    [CmdletBinding()]
    param ()

    begin { }

    process {
        $hash = @{stop = $true}
        Invoke-SmartPidPublish -hash $hash
    }
    end { }
}
