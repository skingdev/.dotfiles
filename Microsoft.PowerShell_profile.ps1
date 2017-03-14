set-location C:\Dev

$Host.UI.RawUI.WindowTitle = 'Shawns Powershell'

. (Resolve-Path ~/Documents/WindowsPowershell/gitutils.ps1)

# Aliases
# Up directory alias. Usage, uX = go up X directories, uuu = go up 3 directories
for($i = 1; $i -le 5; $i++){
  $u =  "".PadLeft($i,"u")
  $unum =  "u$i"
  $d =  $u.Replace("u","../")
  Invoke-Expression "function $u { push-location $d }"
  Invoke-Expression "function $unum { push-location $d }"
}

new-item alias:ll -value dir



function prompt {
	$path = ""
	$pathbits = ([string]$pwd).split("\", [System.StringSplitOptions]::RemoveEmptyEntries)
	if($pathbits.length -eq 1) {
		$path = $pathbits[0] + "\"
	} else {
		$path = $pathbits[$pathbits.length - 1]
	}
	
	$host.UI.RawUi.WindowTitle = $path
    Write-Host($PWD.path) -nonewline -foregroundcolor Green 
    
    if (isCurrentDirectoryGitRepository) {
        $status = gitStatus
        $currentBranch = $status["branch"]
        
        Write-Host(' [') -nonewline -foregroundcolor Yellow
        if ($status["ahead"] -eq $FALSE) {
            # We are not ahead of origin
            Write-Host($currentBranch) -nonewline -foregroundcolor Cyan
        } else {
            # We are ahead of origin
            Write-Host($currentBranch) -nonewline -foregroundcolor Red
        }
        
        if ($status["added"] -gt 0) {
        	Write-Host('+') -nonewline -foregroundcolor Yellow
        }

        if ($status["modified"] -gt 0) {
        	Write-Host('~') -nonewline -foregroundcolor Yellow
        }

        if ($status["deleted"] -gt 0) {
        	Write-Host('-') -nonewline -foregroundcolor Yellow
        }

        if ($status["untracked"] -ne $FALSE) {
            Write-Host('!') -nonewline -foregroundcolor Yellow
        }
        
        Write-Host(']') -nonewline -foregroundcolor Yellow 
    }
    
	Write-Host('>') -nonewline -foregroundcolor Green    
	return " "
}

Clear-Host
