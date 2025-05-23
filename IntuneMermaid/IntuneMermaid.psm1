<#
.SYNOPSIS
      This module provides a function to generate a mermaid diagrams for Intune resources'
 
.NOTES
    Author: Jose Schenardie
    Contact: @schenardie
    Website: https://intune.tech
#>
[CmdletBinding()]
Param()
Process {
    # Locate all the public and private function specific files
    $PublicFunctions = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath "Public") -Filter "*.ps1" -ErrorAction SilentlyContinue)
    $PrivateFunctions = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath "Private") -Filter "*.ps1" -ErrorAction SilentlyContinue)

    # Dot source the function files
    foreach ($FunctionFile in @($PublicFunctions + $PrivateFunctions)) {
        try {
            . $FunctionFile.FullName -ErrorAction Stop
        }
        catch [System.Exception] {
            Write-Error -Message "Failed to import function '$($FunctionFile.FullName)' with error: $($_.Exception.Message)"
        }
    }
    #Set-Alias New-IMG New-IntuneMermaidGraph 
    New-Alias -Name 'New-IMG' -value 'New-IntuneMermaidGraph'

    Export-ModuleMember -Function $PublicFunctions.BaseName -Alias New-IMG
}