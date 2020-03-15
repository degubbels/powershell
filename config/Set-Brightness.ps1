Function Set-Brightness {

  [cmdletbinding()]
  Param(
      [Parameter(Position=0, Mandatory=$True,
      HelpMessage="Brightness 0-100")]
      [Alias("val")]
      [ValidateNotNullorEmpty()]
      [int]$Value
  )

  (Get-WmiObject -Namespace root/WMI -Class WmiMonitorBrightnessMethods).WmiSetBrightness(1,$Value)
  write-host "`n  Brightness set to "$Value"`n"

}
