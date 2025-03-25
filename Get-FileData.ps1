function Get-FilesFromDirectory {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$DirectoryPath
    )

    # Validate the directory exists
    if (-not (Test-Path -Path $DirectoryPath -PathType Container)) {
        Write-Error "Directory does not exist: $DirectoryPath"
        return $null
    }

    # Retrieve only files from the specified directory
    $files = Get-ChildItem -Path $DirectoryPath -File -ErrorAction Stop

    # Create an array of PSCustomObjects with file details
    $result = foreach ($file in $files) {
        [PSCustomObject]@{
            Name     = $file.Name
            Size     = $file.Length
            Location = $file.DirectoryName
        }
    }

    Write-Verbose "Found $($result.Count) file(s) in directory $DirectoryPath"
    return $result
}

# Example usage:
# $fileList = Get-FilesFromDirectory -DirectoryPath "\\Server\Share\Folder"
# $fileList | Format-Table -AutoSize