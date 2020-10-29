function Invoke-SmartPidPublish {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $hash
    )

    begin { }

    process {
        $json = $hash | ConvertTo-Json
        # $json = @{start='auto'; recipe=1; pump='off'} | ConvertTo-Json
        # $json = @{start='manual';pump='off'} | ConvertTo-Json
        # $json = @{'mash SP'=50} | ConvertTo-Json
        $MqttClient.Publish("smartpid/homebrewing/6e945ef5af6404/commands", [System.Text.Encoding]::UTF8.GetBytes($json)) | Out-Null
    }
    end { }
}
