function Start-SmartPidManualMode {
    [CmdletBinding()]
    param ()

    begin { }

    process {
        $hash = @{start = 'manual'
            pump        = 'off'
        }
        Invoke-SmartPidPublish -hash $hash
        #$MqttClient.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes('{mode=manual,}')) | Out-Null
        #$MqttClient.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes('{"pump":"off"}'))
    }
    end { }
}
