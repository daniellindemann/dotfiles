Write-Host ""
Write-Host "Setting up windows dotfiles"
Write-Host

# get current dir
$working_dir=$pwd.Path

# linking common dotfiles
# gitconfig, npmrc, zshrc, etc.
Write-Host "Linkin common dotfiles" -ForegroundColor Magenta
New-Item -ItemType SymbolicLink -Path $HOME -Name '.gitconfig' -Value "$working_dir/gitconfig" -Verbose | Out-Null
New-Item -ItemType SymbolicLink -Path $HOME -Name '.zshrc' -Value "$working_dir/zshrc" -Verbose | Out-Null
New-Item -ItemType SymbolicLink -Path $HOME -Name '.editorconfig' -Value "$working_dir/editorconfig" -Verbose | Out-Null
New-Item -ItemType SymbolicLink -Path $HOME -Name 'angular-config.json' -Value "$working_dir/angular-config.json" -Verbose | Out-Null
Write-Host "Common dotfiles linked" -ForegroundColor Green

# setup vs code
Write-Host "Setting up code" -ForegroundColor Magenta

# setup folder structure
$codefolder_location="$HOME/AppData/Roaming"
$codefolder_name="Code"
New-Item "$codefolder_location/$codefolder_name" -ItemType Directory  -Force
$userfolder="$codefolder_location/$codefolder_name/User"

# remove code folder if it already exists
if(Test-Path $userfolder) {
    Write-Host "User folder already exists, will remove it" -ForegroundColor Yellow
    Remove-Item $userfolder -Force -Recurse
}

# link code config
New-Item -ItemType SymbolicLink -Path "$codefolder_location/$codefolder_name" -Name "User" -Value "$working_dir/$codefolder_name/User" -Verbose | Out-Null

Write-Host "Code setup completed" -ForegroundColor Green

# setup vs code
Write-Host "Setting up windows terminal" -ForegroundColor Magenta
$terminalfolder_location="$HOME/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe"
New-Item $terminalfolder_location -ItemType Directory -Force

# remove local state folder
if(Test-Path "$userfolder/LocalState") {
    Write-Host "LocalState folder already exists, will remove it" -ForegroundColor Yellow
    Remove-Item "$userfolder/LocalState" -Force -Recurse
}

New-Itemm -ItemType SymbolicLink -Path $terminalfolder_location -Name "LocalState" -Value "$working_dir/LocalState" -Verbose | Out-Null

Write-Host "Windows terminal setup completed" -ForegroundColor Green

Write-Host "dotfiles installed" -ForegroundColor Green
