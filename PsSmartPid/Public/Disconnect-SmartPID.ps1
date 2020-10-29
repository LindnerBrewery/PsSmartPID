function Disconnect-SmartPid {
    param ()
    #remove Event
    Get-EventSubscriber | Where-Object EventName -eq 'MqttMsgPublishReceived' | Unregister-Event
    $mqttclient.disconnect()

    #remove variables
    Remove-Variable -Name current -Scope global -ErrorAction SilentlyContinue
    Remove-Variable -Name mqttclient -Scope script -ErrorAction SilentlyContinue
}
