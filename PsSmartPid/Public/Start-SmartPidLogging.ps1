function Start-SmartPidLogging {
    param (
    )
    Get-EventSubscriber | Where-Object EventName -eq 'MqttMsgPublishReceived' | Unregister-Event

    $Global:current = [System.Collections.ArrayList]::new()
    $null = $MqttClient.Subscribe("smartpid/homebrewing/$ID/#", 0)
    $null = Register-ObjectEvent -InputObject $MqttClient -EventName MqttMsgPublishReceived -Action {
        $obj = '' | Select-Object Timestamp, topic, content
        $obj.Timestamp = Get-Date #(Get-Date -Format "yyy-MM-ddTHH:mm:ss.ms000K")
        $obj.topic = $args[1].topic
        $obj.content = (([System.Text.Encoding]::ASCII.GetString($args[1].Message)) | ConvertFrom-Json | Select-Object * )
        $current.add($obj)
    }
}
