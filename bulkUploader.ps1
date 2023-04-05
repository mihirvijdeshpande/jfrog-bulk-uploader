$dir=$(pwd)
$files = GCI . -File '*.xml'
foreach ($file in $files){

  $MyXml = [xml](Get-Content $file)

  $group = $MyXml.project.groupId
  if (!$group){ $group = $MyXml.project.parent.groupId } 

  $artifact = $MyXml.project.artifactId

  $version = $MyXml.project.version
  if (!$version){ $version = $MyXml.project.parent.version  } 

  $groupFolder = $group.replace('.','/')
  mkdir -Force $groupFolder/$artifact/$version
  mv $artifact-$version* $groupFolder/$artifact/$version/
  cd $dir #traversing back to parent directory

  .\jf.exe rt u "./" libs-release --exclusions="*.exe;*.ps1"
}
