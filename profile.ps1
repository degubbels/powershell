$MyDocuments = [Environment]::GetFolderPath("mydocuments")

# Folders
$u = $home
$data = "C:\Users\s161804\Google Drive\Data\"
$uni =  "C:\Users\s161804\Google Drive\Data\Documents\University\"
$script = "D:\dev\script\powershell\"

# Modules
Import-Module $script\modules\VirtualEnvWrapper.psm1
Import-Module posh-git

# Might be worth it with dfferent settings
#Install-GuiCompletion -key tab


function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function prompt {
  $host.ui.rawui.WindowTitle = "PowerShell - $pwd"

  $rtn = '>'
  $pwdstring = $pwd.toString()

  $pwdstring = $pwdstring.replace("C:\Users\deg",'~')

  $pwdlist = ($pwdstring -split '\\')
  If ($pwdstring.length -le 20)
  {
    $rtn = $pwdstring
  }
  ElseIf (($pwdlist[-1]+$pwdlist[-2]).length -le 20)
  {
    $rtn = $pwdlist[0] + '\..\'+ $pwdlist[-2] + '\' + $pwdlist[-1]
  }
  Else
  {
    $rtn = $pwdlist[0] + '\..\' + $pwdlist[-1]
  }

  # Admin indicator
  If (Test-Administrator) {
    Write-Host "!" -NoNewLine -ForegroundColor Red
  }

  # Git branch indicator
  If ($status = Get-GitStatus -Force)
  {
    
    $gitprompt = "["

    if (-not ($status.Branch -eq "master") -or (-not($status.Branch -eq "main")) ) {
      $remotebehind = git rev-list --left-only --count master...@
      $remoteahead = git rev-list --right-only --count master...@
      $gitprompt += $remotebehind + "|" + $remoteahead + " - "
    }

    
    $gitprompt += $status.Branch
    if ($status.BehindBy) {
      $gitprompt += " -" + $status.BehindBy
    }
    if ($status.AheadBy) {
      $gitprompt += " +" + $status.AheadBy
    }
    $gitprompt += "] "
    $gitprompt = $gitprompt.Replace("feature", "f")
    If ($status.UpstreamGone)
    {
      Write-Host $gitprompt -NoNewLine -ForegroundColor Red
    } ElseIf (-not $status.HasWorking)
    {
      Write-Host $gitprompt -NoNewLine -ForegroundColor White
    }
    Else
    {
      Write-Host $gitprompt -NoNewLine -ForegroundColor Cyan
    }
  }

  $rtn += ">"
  return $rtn
}

###############################################################################
### Scripts
###############################################################################

. $script"\config\Set-Brightness.ps1"

################################################################################
# Aliases
################################################################################

# Alias
function dockup {
docker-compose up -d
docker-compose logs -f
}

# Scripts
set-alias stay-awake $script"config\stay-awake.ps1"

# Commands
set-alias get-app $script"command\get-app.ps1"

# Programs
function web {C:\Programs\Vivaldi\Application\vivaldi.exe chrome:\\newtab}

#clear
clear