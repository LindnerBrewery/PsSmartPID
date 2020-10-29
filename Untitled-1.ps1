$Global:x = [System.Collections.ArrayList]::new()
$null = $SmartPidConnection.Subscribe("smartpid/homebrewing/6e945ef5af6404/#", 0)
$null = Register-ObjectEvent -InputObject $SmartPidConnection -EventName MqttMsgPublishReceived -Action {
    $obj = '' | Select-Object Timestamp, topic, content
    $obj.Timestamp = Get-Date #(Get-Date -Format "yyy-MM-ddTHH:mm:ss.ms000K")
    $obj.topic = $args[1].topic
    $obj.content = (([System.Text.Encoding]::ASCII.GetString($args[1].Message)) | ConvertFrom-Json | Select-Object * )
    $x.add($obj)
}



$SmartPidConnection.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes('{"stop":True}'))
$SmartPidConnection.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes('{"pump":"on"}'))



$SmartPidConnection.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes("{`"stop`":true}"))
$Connection.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes($json))
$json = @{start='auto'; recipe=1; pump='off'} | ConvertTo-Json

$json = @{start='manual';pump='off'} | ConvertTo-Json


$Connection.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes($json))
