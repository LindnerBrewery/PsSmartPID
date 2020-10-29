function Stop-SmartPidPump {
    [CmdletBinding()]
    param ()

    begin { }

    process {
        #$MqttClient.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes('{"pump":"on"}'))
        #$SmartPidConnection.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes('{"pump":"off"}')) | Out-Null
        $hash = @{pump = "off"}
        Invoke-SmartPidPublish -hash $hash
    }
    end { }
}
