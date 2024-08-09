# Run by using:
# .\git.ps1

# Set the execution policy to allow running scripts in this session
Set-ExecutionPolicy RemoteSigned -Scope Process

# Add files 
git add .

# Prompt the user for a commit message
$commitMessage = Read-Host "Enter commit message"

# Commit files
git commit -m "$commitMessage"

# Push files
git push