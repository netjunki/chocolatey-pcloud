$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url        = ((Invoke-webrequest -URI "https://u.pcloud.link/publink/show?code=XZar9wVZibWL4VKCgBHNCynCh1gVtfs8DFty").Content | findstr "downloadlink").Split('"')[3].Replace('\/','/')
$url64      = ((Invoke-webrequest -URI "https://u.pcloud.link/publink/show?code=XZ9r9wVZ5BKGcBkvjyYLcjD48mwMQY94T047").Content | findstr "downloadlink").Split('"')[3].Replace('\/','/')

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  softwareName  = 'pcloud*'

  checksum      = 'EF56AF892813A86EA37E268D194321F69F97A31F04FAEF11A4DD473D58B06322'
  checksumType  = 'sha256'
  checksum64    = 'AD7820C5046C4A61C7ACA2B768013A624AB88421B3E9869D5F123BDE09B83C9E'
  checksumType64= 'sha256'

  silentArgs    = "/install /quiet"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs