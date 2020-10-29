function Connect-SmartPid {
    param ()
    $config = Get-ConnectionConfiguration
    if (!($config )) {
        Throw "Configuration could not be found. Please set configuration with Set-ConnectionConfiguration command"
    }
    $mqttPack = Get-Package m2mqtt
    $x = [System.IO.FileInfo]::new($mqttPack.Source)
    Add-Type -Path "$($x.Directory)\lib\net45\M2Mqtt.Net.dll"
    $script:MqttClient = [uPLibrary.Networking.M2Mqtt.MqttClient]($config.MQTTServer)
    $mqttclient.Connect([guid]::NewGuid(), $config.Credential.username, $config.Credential.GetNetworkCredential().password ) | Out-Null
    <#
    $Global:current = [System.Collections.ArrayList]::new()
    $null = $MqttClient.Subscribe("smartpid/homebrewing/6e945ef5af6404/#", 0)
    $null = Register-ObjectEvent -InputObject $MqttClient -EventName MqttMsgPublishReceived -Action {
        $obj = '' | Select-Object Timestamp, topic, content
        $obj.Timestamp = Get-Date #(Get-Date -Format "yyy-MM-ddTHH:mm:ss.ms000K")
        $obj.topic = $args[1].topic
        $obj.content = (([System.Text.Encoding]::ASCII.GetString($args[1].Message)) | ConvertFrom-Json | Select-Object * )
        $current.add($obj)
    }
    #>
    return $mqttclient
}
