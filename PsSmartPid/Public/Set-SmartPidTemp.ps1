function Set-SmartPidTemp {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [ValidateRange(1, 100)]
        [Int16]
        $Temperature
    )

    begin { }

    process {
        #$MqttClient.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes('{"pump":"on"}'))
        #$MqttClient.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes("{`"mash SP`":$Temperature}")) | Out-Null
        $hash = @{'mash SP' = $Temperature }
        Invoke-SmartPidPublish -hash $hash
    }
    end { }
}
