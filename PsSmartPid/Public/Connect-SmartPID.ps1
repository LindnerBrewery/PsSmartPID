function Connect-SmartPid {
    param ()
    $config = Get-ConnectionConfiguration
    if (!($config )) {
        Throw "Configuration could not be found. Please set configuration with Set-ConnectionConfiguration command"
    }
    $script:ID = $config.DeviceID
    $mqttPack = Get-Package m2mqtt
    #$x = [System.IO.FileInfo]::new($mqttPack.Source)
    $x = [System.IO.FileInfo]::new($PSScriptRoot)

    #Add-Type -Path "$($x.Directory)\lib\net45\M2Mqtt.Net.dll"
    Add-Type -Path "$($x.Directory)\lib\net45\M2Mqtt.Net.dll"
    $script:MqttClient = [uPLibrary.Networking.M2Mqtt.MqttClient]($config.MQTTServer)
    $mqttclient.Connect([guid]::NewGuid(), $config.Credential.username, $config.Credential.GetNetworkCredential().password ) | Out-Null
    return $mqttclient
}
