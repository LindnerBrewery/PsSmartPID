@{
    PSDependOptions = @{
        Target    = '$DependencyFolder\dependencies' # I want all my dependencies installed here
        AddToPath = $True            # I want to prepend project to $ENV:Path and $ENV:PSModulePath

    }
    'Pester' = @{
        Version = '5.1.1'
        Parameters = @{
            SkipPublisherCheck = $true
        }
    }
    'psake' = @{
        Version = '4.9.0'
    }
    'BuildHelpers' = @{
        Version = '2.0.16'
    }
    'PowerShellBuild' = @{
        Version = '0.6.1'
    }
    'PSScriptAnalyzer' = @{
        Version = '1.19.1'
    }
    'Configuration' = @{
        Version = 'latest'
    }
    'M2Mqtt'      = @{
        DependencyType = 'Package'
        Source         = 'nuget.org'
        Parameters     = @{
            SkipDependencies = $true
        }
    }
}
