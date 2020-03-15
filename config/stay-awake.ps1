$bool = $args[0]

If (($args.Count -eq 0) -or ($bool -eq "1") -or ($bool -eq "true") -or ($bool -eq "yes")) {

  powercfg -s 24036f3f-e2e1-4c62-832a-b2238d5a4826
  write-host -foregroundcolor green "`n  PC will now stay awake`n"
} ElseIf (($bool -eq "0") -or ($bool -eq "false") -or ($bool -eq "no")) {

  powercfg -s d04f0640-ef46-46f8-931c-d47908529087
  write-host -foregroundcolor green "`n  PC will now hibernate`n"
} Else {

  write-error ("Invalid argument: " + $bool + "`n `n  enter true to enable stay-awake mode,`n  enter false to disable stay-awake mode`n `n")
}
