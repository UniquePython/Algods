# Run by using:
# .\upload_package.ps1

# Check if Python is installed
if (-not (Get-Command py -ErrorAction SilentlyContinue)) {
    Write-Error "Python is not installed or not found in PATH."
    exit 1
}

# Set the execution policy to allow running scripts in this session if not already set
$currentPolicy = Get-ExecutionPolicy -Scope Process
if ($currentPolicy -ne 'RemoteSigned') {
    Set-ExecutionPolicy RemoteSigned -Scope Process -Force
}

# Update pip to the latest version
Write-Host "Upgrading pip to the latest version..."
py -m pip install --upgrade pip
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to upgrade pip. Please check for errors."
    exit 1
}

# Install or upgrade the build package
Write-Host "Installing or upgrading the build package..."
py -m pip install --upgrade build
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to install or upgrade the build package. Please check for errors."
    exit 1
}

# Build the package
Write-Host "Building the package..."
py -m build
if ($LASTEXITCODE -ne 0) {
    Write-Error "Package build failed. Please check for errors."
    exit 1
}

# Install or upgrade the twine package
Write-Host "Installing or upgrading the twine package..."
py -m pip install --upgrade twine
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to install or upgrade the twine package. Please check for errors."
    exit 1
}

# Upload the package to PyPI
Write-Host "Uploading the package to PyPI..."
py -m twine upload --repository pypi dist/*
if ($LASTEXITCODE -ne 0) {
    Write-Error "Package upload failed. Please check for errors."
    exit 1
}

Write-Host "Package upload completed successfully."
