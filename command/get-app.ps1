Get-Process | ? {$_.MainWindowHandle -ne 0 }
