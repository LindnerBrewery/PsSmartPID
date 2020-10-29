<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    Example of how to use this cmdlet
.EXAMPLE
    Another example of how to use this cmdlet
.INPUTS
    Inputs to this cmdlet (if any)
.OUTPUTS
    Output from this cmdlet (if any)
.NOTES
    General notes
.COMPONENT
    The component this cmdlet belongs to
.ROLE
    The role this cmdlet belongs to
.FUNCTIONALITY
    The functionality that best describes this cmdlet
#>
function Set-ConnectionConfiguration {
    [CmdletBinding()]
    Param (
        # Param1 help description
        [Parameter(Mandatory = $true,
            Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Alias("Url", "IP")]
        $MQTTServer,

        # Param2 help description
        [Parameter(Mandatory = $true,
            Position = 1)]
        [pscredential]
        $Credential,

        # Param3 help description
        [Parameter(Mandatory = $true,
            Position = 2)]
        [ValidateLength(14, 14)]
        [String]
        $SmartPIDSerial
    )

    begin {
    }

    process {
        $version = [version]'1.0'
        $configurationHash = @{Version = $version
            MQTTServer                 = $MQTTServer
            Credential                 = $Credential
            SmartPIDSerial                = $SmartPIDSerial
        }
        Export-Configuration -InputObject $configurationHash

    }

    end {
    }
}
