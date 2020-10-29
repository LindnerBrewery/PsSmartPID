function Suspend-SmartPid {
    [CmdletBinding()]
    param ()

    begin { }

    process {
        #$MqttClient.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes('{"pump":"on"}'))
        #$SmartPidConnection.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes("{`"pause`":true}")) | Out-Null
        $hash = @{pause = $true}
        Invoke-SmartPidPublish -hash $hash
    }
    end { }
}
