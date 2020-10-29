function Get-DeviceID {
    <#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
    [CmdletBinding()]
    param (
        [parameter(Mandatory,
            Position = 0)]
        [ValidateLength(14,14)]
        #[ValidatePattern('^[0-9a-f]')]
        [String]$serial
    )

    begin { }

    process {
        $map = @{ }
        $map['0'] = "0000"
        $map['1'] = "1000"
        $map['2'] = "0100"
        $map['3'] = "1100"
        $map['4'] = "0010"
        $map['5'] = "1010"
        $map['6'] = "0110"
        $map['7'] = "1110"
        $map['8'] = "0001"
        $map['9'] = "1001"
        $map['A'] = "0101"
        $map['B'] = "1101"
        $map['C'] = "0011"
        $map['D'] = "1011"
        $map['E'] = "0111"
        $map['F'] = "1111"
        $map['a'] = "0101"
        $map['b'] = "1101"
        $map['c'] = "0011"
        $map['d'] = "1011"
        $map['e'] = "0111"
        $map['f'] = "1111"

        $scrambledSerNo = [System.Collections.ArrayList]::new()
        $xorValues = @(0x14, 0xE5, 0xDE, 0x04, 0xAF, 0x6E, 0x30)

        $j = 0
        for ($i = 0; $i -lt $serial.length; $i = $i + 2) {
            $ch1 = $serial.Substring($i, 1);
            $ch2 = $serial.Substring($i + 1, 1);

            $s1 = $map[$ch1];
            $s2 = $map[$ch2];

            $xorValue = [convert]::ToInt32($s2 + $s1, 2) -bxor $xorValues[$j];

            $scrambledSerNo += $xorValue.ToString('X').PadLeft(2, '0')
            $j ++
        }

        $sEncryptedId = $scrambledSerNo[5] + $scrambledSerNo[0] + $scrambledSerNo[2] + $scrambledSerNo[1] + $scrambledSerNo[4] + $scrambledSerNo[6] + $scrambledSerNo[3]
        $sEncryptedId = $sEncryptedId.toLower()
        $sEncryptedId
    }

    end { }
}
