function Set-SmartPidCountdown {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Object]
        $SmartPidConnection,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [ValidateRange(1, 600)]
        [Int16]
        $Min
    )

    begin { }

    process {
        $countdown = $Min * 60
        $SmartPidConnection.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes("{`"countdown`":$countdown}")) | Out-Null
    }
    end { }
}
