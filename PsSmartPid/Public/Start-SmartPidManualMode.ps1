function Start-SmartPidManualMode {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Object]
        $SmartPidConnection
    )

    begin { }

    process {
        $SmartPidConnection.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes('{mode=manual,}')) | Out-Null
        #$MqttClient.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes('{"pump":"off"}'))
    }
    end { }
}
