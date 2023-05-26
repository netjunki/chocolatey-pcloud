$ErrorActionPreference = 'Stop'

function getPCloudInstallerUrl {
  param (
    $FileCode
  )
  ((Invoke-WebRequest -UseBasicParsing -Uri "https://u.pcloud.link/publink/show?code=$FileCode").Content | findstr "downloadlink").Split('"')[3].Replace('\/','/')
}

$url        = getPCloudInstallerUrl -FileCode "XZar9wVZibWL4VKCgBHNCynCh1gVtfs8DFty" # 4.1.1 for x86
$url64      = getPCloudInstallerUrl -FileCode "XZ9r9wVZ5BKGcBkvjyYLcjD48mwMQY94T047" # 4.1.1 for x64

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
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