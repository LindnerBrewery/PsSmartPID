﻿function Start-SmartPidPump {
    [CmdletBinding()]
    param ()

    begin { }

    process {
        $hash = @{pump = "on"}
        Invoke-SmartPidPublish -hash $hash
    }
    end { }
}
