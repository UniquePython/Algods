# Run by using:
# .\git.ps1

# Check if Git is installed
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "Git is not installed or not found in PATH."
    exit 1
}

# Set the execution policy to allow running scripts in this session if not already set
$currentPolicy = Get-ExecutionPolicy -Scope Process
if ($currentPolicy -ne 'RemoteSigned') {
    Set-ExecutionPolicy RemoteSigned -Scope Process -Force
}

# Add files 
Write-Host "Adding all changes..."
git add .

# Prompt the user for a commit message
$commitMessage = Read-Host "Enter commit message"

# Check if commit message is not empty
if ([string]::IsNullOrWhiteSpace($commitMessage)) {
    Write-Error "Commit message cannot be empty."
    exit 1
}

# Commit files
Write-Host "Committing changes..."
git commit -m "$commitMessage"

# Check if the commit was successful
if ($LASTEXITCODE -ne 0) {
    Write-Error "Commit failed. Please check for errors."
    exit 1
}

# Push files
Write-Host "Pushing to remote repository..."
git push

# Check if the push was successful
if ($LASTEXITCODE -ne 0) {
    Write-Error "Push failed. Please check for errors."
    exit 1
}

# Define git repo link
$url = "https://github.com/UniquePython/Algods.git"

# Open git repo
Write-Host "Opening the GitHub repository in the default browser..."
Start-Process $url
