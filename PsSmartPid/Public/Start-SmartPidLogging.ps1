function Start-SmartPidLogging {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Object]
        $SmartPidConnection
    )
    $Global:current = [System.Collections.ArrayList]::new()
    $null = $SmartPidConnection.Subscribe("smartpid/homebrewing/6e945ef5af6404/#", 0)
    $null = Register-ObjectEvent -InputObject $SmartPidConnection -EventName MqttMsgPublishReceived -Action {
        $obj = '' | Select-Object Timestamp, topic, content
        $obj.Timestamp = Get-Date #(Get-Date -Format "yyy-MM-ddTHH:mm:ss.ms000K")
        $obj.topic = $args[1].topic
        $obj.content = (([System.Text.Encoding]::ASCII.GetString($args[1].Message)) | ConvertFrom-Json | Select-Object * )
        $current.add($obj)
    }
}
