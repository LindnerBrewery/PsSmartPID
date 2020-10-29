function Set-SmartPidPower {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [ValidateRange(0, 100)]
        [Int16]
        $Power
    )

    begin { }

    process {
        #$SmartPidConnection.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes("{`"PWM`":$Power}")) | Out-Null
        $hash = @{PWM = $Power}
        Invoke-SmartPidPublish -hash $hash
    }
    end { }
}
