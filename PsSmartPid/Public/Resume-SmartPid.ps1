function Resume-SmartPid {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Object]
        $SmartPidConnection
    )

    begin { }

    process {
        #$SmartPidConnection.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes("{`"pause`":false}")) | Out-Null
        $hash = @{pause = $false }
        Invoke-SmartPidPublish -hash $hash
    }
    end { }
}
